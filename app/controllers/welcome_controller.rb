class WelcomeController < ApplicationController

	before_action :signed_in_member

	def index
		#Payment has been successful, create the forum details
		@member = current_member
		puts "PASSWORD = " + @member.forum_details.forum_password

		client = Mysql2::Client.new(
			:host => "188.65.117.70",
			:database => "demu_forum",
			:username => "demu_membership",
			:password => "st4rbuck2014m3mb3r"
  		)

        puts "NAME=" + @member.forum_details.forum_name
        results = client.query("SELECT passwd, memberName FROM smf_members WHERE memberName = '" + @member.forum_details.forum_name + "'")
        if results.count == 0

        	results = client.query("SELECT max(ID_MEMBER) + 1 as maxid FROM smf_members")
        	maxid = results.first["maxid"].to_s

        	puts "NOTHING FOUND, CREATING NEW USER!"
        	query = "INSERT INTO smf_members (ID_MEMBER, memberName, dateregistered, ID_GROUP, realName, passwd, emailAddress) "
        	query += "VALUES ("
        	query += "'" + maxid + "'"
        	query += ",'" + @member.forum_details.forum_name + "'"
        	query += ",'" + Date.today.to_time.to_i.to_s + "'"
        	query += ",'0'"
        	query += ",'" + @member.forename + " " + @member.surname + "'"
        	query += ",'" + @member.forum_details.forum_password + "'"
        	query += ",'" + @member.contact_details.email + "')"

			results = client.query(query)

			@member.forum_details.forum_id = maxid
			@member.forum_details.save
        else
        	puts "FOUND RESULT"
        end

	end

  	private

		def signed_in_member
      		redirect_to signin_url, :flash => {:danger => "Please sign in."} unless signed_in?
    	end

end
