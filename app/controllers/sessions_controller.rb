class SessionsController < ApplicationController
	def new
  	end

	def create
		details = ForumDetails.find_by(forum_name: params[:session][:login].downcase)
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
			flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      		render 'new'
		end
	end

	def destroy
    	sign_out
    	redirect_to root_url
  	end
end
