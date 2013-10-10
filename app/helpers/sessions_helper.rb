module SessionsHelper
	def sign_in(member)
	    remember_token = ForumDetails.new_remember_token
	    cookies.permanent[:remember_token] = remember_token
	    member.forum_details.update_attribute(:remember_token, ForumDetails.encrypt(remember_token))
	    self.current_member = member
	end

	def sign_out
    	self.current_member = nil
    	cookies.delete(:remember_token)
  	end

	def current_member=(member)
		@current_member = member
	end

	def current_member
		remember_token = ForumDetails.encrypt(cookies[:remember_token])
		forum_details = ForumDetails.find_by(remember_token: remember_token)
		if !forum_details.nil?
			@current_member ||= forum_details.member
		end
		@current_member
	end

	def current_member?(member)
    	member == current_member
  	end

	def signed_in?
 		!current_member.nil?
	end

	def member_admin?
		current_member.member_admin? if !current_member.nil?
	end

	def area_group_admin?
		result = false
		result = current_member.area_group_admin? if !current_member.nil?
		if !result
			#member_admins are area group admins too!
			result = current_member.member_admin? if !current_member.nil?
		end
		result
	end

end
