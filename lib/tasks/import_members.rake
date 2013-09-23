desc "Imports the members data"
task :import_members => :environment do

	require 'csv' 
  
	csv_text = File.read('lib/tasks/TEST_IMPORT_TO_DATABASE_20130922.csv')
	csv = CSV.parse(csv_text, :headers => true)
	csv.each do |row|
  		puts 'IMPORTING: ' + row['Membership number'] + ' ' + row['Forename'] + ' ' + row['Surname']

  		memberdetails = {forename: row['Forename'], surname: row['Surname']}
  		memberdetails[:notes] = row['Notes - Public']
      memberdetails[:membership_number] = row['Membership number']

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
      
      entitlementdata = {endDate: row['Renewal Date']}
      unless row['Renewal Date'].to_s == ''
        entitlement = member.entitlement_periods.build(entitlementdata)
      end

      unless row['Payment method'].to_s == ''
        paymentdata = {amount_in_pence: (row['Amount paid'].to_i * 100), payment_date: row['Date paid']}
        case row['Payment method']
        when 'Paypal'
          paymentdata[:payment_method] = PaymentMethod.find_by_payment_method('paypal')
        when 'BP'
          paymentdata[:payment_method] = PaymentMethod.find_by_payment_method('bank transfer')
        when 'Cheque'
          paymentdata[:payment_method] = PaymentMethod.find_by_payment_method('cheque')
        when 'Cash'
          paymentdata[:payment_method] = PaymentMethod.find_by_payment_method('cash')
        when 'DD'
          paymentdata[:payment_method] = PaymentMethod.find_by_payment_method('direct debit')
        else
          paymentdata[:payment_method] = PaymentMethod.find_by_payment_method('cash')
        end
        payment = entitlement.build_payment(paymentdata)
      end

      member.save

      unless member.persisted?
        puts member.errors.to_yaml unless payment.nil?
        puts entitlement.errors.to_yaml unless payment.nil?
        puts payment.errors.to_yaml unless payment.nil?
      end
      puts "Saved=" + member.persisted?.to_s
        
	end

end