class SessionsController < ApplicationController
	def new
  	end

	def create
		puts "Creating session"
		details = ForumDetails.find(:first, :conditions => [ "lower(forum_name) = ?", params[:session][:login].downcase ])
		puts "Found forum details:" + details.to_s
		if details && details.authenticate(params[:session][:password])
			# Sign the user in and redirect to the user's show page.
			member = details.member
			sign_in member

			if params[:session][:fromnav]
				puts "back"
				redirect_to :back
			else
				puts "to_member"
      			redirect_to member
      		end
		else
			# Create an error message and re-render the signin form.
			flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      		render 'new'
		end
	end

	def destroy
    	sign_out
    	redirect_to "/"
  	end
end
