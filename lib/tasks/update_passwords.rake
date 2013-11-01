desc "Updates members with a password from the forum database"
task :update_passwords => :environment do

  client = Mysql2::Client.new(
            :host => "188.65.117.70",
            :database => "demu_forum",
            :username => "demu_membership",
            :password => "PwfDEMUforum2009"
  )

  Member.all.each do |member|
    unless member.forum_details.nil?
      unless member.forum_details.forum_name.nil?

        puts "NAME=" + member.forum_details.forum_name
        results = client.query("SELECT passwd, memberName FROM smf_members WHERE memberName = '" + member.forum_details.forum_name + "'")
          results.each(:as => :hash) do |row| 
          puts "PASSWORD=" + row["passwd"]
          member.forum_details.forum_password = row["passwd"]
          member.forum_details.forum_name = row["memberName"]
          member.forum_details.save
        end

      end
    end
  end

  results = client.query("SELECT passwd FROM smf_members WHERE memberName = 'lyneux'")
  results.each(:as => :hash) do |row| 
    puts row["passwd"] 
  end

end