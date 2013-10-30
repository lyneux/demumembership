desc "Updates members with a password from the forum database"
task :update_passwords => :environment do

  @connection = ActiveRecord::Base.establish_connection(
            :adapter => "mysql2",
            :host => "188.65.117.70",
            :database => "demu_forum",
            :username => "demu_membership",
            :password => "PwfDEMUforum2009"
  )




  sql = "SELECT * FROM smf_members WHERE memberName = 'lyneux'"
  @result = @connection.connection.execute(sql);
  @result.each(:as => :hash) do |row| 
    puts row["passwd"] 
  end

end