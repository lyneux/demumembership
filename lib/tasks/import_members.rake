desc "Imports the members data"
task :import_members => :environment do

	require 'csv' 
  
	csv_text = File.read('lib/tasks/TEST_IMPORT_TO_DATABASE_20131030.csv')
	csv = CSV.parse(csv_text, :headers => true)
	csv.each do |row|
  		puts 'IMPORTING: ' + row['Membership number'] + ' ' + row['Forename'] + ' ' + row['Surname']

  		memberdetails = {forename: row['Forename'], surname: row['Surname']}
  		memberdetails[:notes] = row['Notes - Public'].to_s + "\n" + row['Notes - Private'].to_s + "\n" + row['Renewed'].to_s + "\n" + row['Forum status'].to_s
      memberdetails[:signup_source] = row['Joined']
      memberdetails[:membership_number] = row['Membership number']
      memberdetails[:date_added] = row['Joined date']

      case row['Mship  Type']
      when 'Senior'
        memberdetails[:member_category] = MemberCategory.find_by_description('OAP UK')
      when 'Junior'
        memberdetails[:member_category] = MemberCategory.find_by_description('Junior UK')
      when 'Family'
        memberdetails[:member_category] = MemberCategory.find_by_description('Family UK')
      when 'Overseas'
        memberdetails[:member_category] = MemberCategory.find_by_description('Rest of World')
      else
        memberdetails[:member_category] = MemberCategory.find_by_description('Adult UK')
      end
  		#puts memberdetails[:member_category].description.to_yaml

      unless row['Quit? (Y/N)'].to_s == ''
        memberdetails[:membership_status] = MembershipStatus.find_by_status('quit')
      else  
        memberdetails[:membership_status] = MembershipStatus.find_by_status('live')
      end

      unless row['Date of birth'].to_s == ''
        memberdetails[:date_of_birth] = row['Date of birth']
      end

      unless row['Area Group'].to_s == ''
        memberdetails[:area_group] = AreaGroup.find_by_name(row['Area Group'].to_s)
      end

      contactdetails = {address_line_1: row['Address1'], address_line_2: row['Address2'], address_line_3: row['Address3']}
      contactdetails[:town] = row['Postal Town']
      contactdetails[:county] = row['County']
      
      if row['Country'].to_s == ''
        contactdetails[:country] = 'United Kingdom'
      else
        contactdetails[:country] = row['Country']
      end
      contactdetails[:postcode] = row['Postcode']
      
      unless row['Telephone'].to_s == ''
        contactdetails[:telephone] = row['Telephone'].delete(' ')
      end

      unless row['Email'].to_s == ''
        contactdetails[:email] = row['Email'].delete(' ')
      end

      #puts memberdetails.to_yaml
      #puts contactdetails.to_yaml

  		member = Member.create(memberdetails)
      contact_details = member.build_contact_details(contactdetails)
      member.save
      
      entitlementdata = {end_date: row['Renewal Date']}
      unless row['Renewal Date'].to_s == ''
        entitlement = member.entitlement_periods.build(entitlementdata)
      end

      unless row['Payment method'].to_s == ''
        payment_status = PaymentStatus.find_by_description('complete')
        paymentdata = {amount_in_pence: (row['Amount paid'].to_i * 100), payment_date: row['Date paid']}
        paymentdata[:payment_status] = payment_status
        paymentdata[:member_id] = member.id
        case row['Payment method']
        when 'Paypal'
          paymentdata[:payment_type] = PaymentType.find_by_description('paypal')
        when 'BP'
          paymentdata[:payment_type] = PaymentType.find_by_description('bank transfer')
        when 'Cheque'
          paymentdata[:payment_type] = PaymentType.find_by_description('cheque')
        when 'Cash'
          paymentdata[:payment_type] = PaymentType.find_by_description('cash')
        when 'DD'
          paymentdata[:payment_type] = PaymentType.find_by_description('direct debit')
        else
          paymentdata[:payment_type] = PaymentType.find_by_description('cash')
        end
        if (!paymentdata[:amount_in_pence].nil? & !paymentdata[:payment_date].nil?)
          payment = entitlement.build_payment(paymentdata)
        end
      end

      #unless row['Forum ID'].to_s == ''
      forumdata = {forum_id: (row['Forum ID']), forum_name: (row['Forum Name'])}
        #forumdata[:forum_name] = row['Forum Name'] unless row['Forum Name'].to_s.delete(' ') == ''
      forumdetails = member.build_forum_details(forumdata)
      #end

      #Set password and role
      if !member.forum_details.nil?
        member.forum_details.forum_password = Digest::SHA1.hexdigest (member.forum_details.forum_name.to_s + 'test')
        member_role = Role.find_by_description(Role::MEMBER)
        member_role = Role.find_by_description(Role::MEMBER_ADMIN) if (member.membership_number == 1571)
        member_role = Role.find_by_description(Role::AREA_GROUP_ADMIN) if (member.membership_number == 51)
        member.forum_details.role = member_role
      end

      if row['Payment method'] == 'DD'
        renewal_type = SubscriptionRenewalType.find_by_description(SubscriptionRenewalType::DIRECT_DEBIT)
      else
        renewal_type = SubscriptionRenewalType.find_by_description(SubscriptionRenewalType::MANUAL)
      end
      subscription_data = {subscription_renewal_type: renewal_type}
      member.build_subscription(subscription_data)

      member.save

      unless member.persisted?
        puts member.errors.to_yaml unless payment.nil?
        puts entitlement.errors.to_yaml unless payment.nil?
        puts payment.errors.to_yaml unless payment.nil?
      end
      puts "Saved=" + member.persisted?.to_s
        
	end

end