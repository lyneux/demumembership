class MembersController < ApplicationController

	def new
		@member = Member.new
		@contact_details = ContactDetails.new
		@max_member_id = Member.maximum("membership_number")
	end

	def create
		puts "Start"

		@member = Member.new(member_params)
		@member.member_category = MemberCategory.find(member_params[:member_category_id])
		@member.source_channel = SourceChannel.find(member_params[:source_channel_id])
		@member.membership_status = MembershipStatus.find_by_status(MembershipStatus::LIVE)
		
		puts "Pre-Contact Details"	
		@contact_details = ContactDetails.new(contact_details_params)
		@member.contact_details = @contact_details

		puts "Pre-Save"
		@member.save
		
		puts "Finished"

		if @member.errors.none?
			redirect_to @member
		else
			render 'new'
		end
		
	end

	def show
		@member = Member.find(params[:id])
	end

	def index
  		@members = Member.all
	end

	def edit
		@member = Member.find(params[:id])
		@contact_details = @member.contact_details
		@max_member_id = Member.maximum("membership_number")
	end
	
	def update

  		@member = Member.find(params[:id])
  		@member.member_category = MemberCategory.find(member_params[:member_category_id])
  		@member.source_channel = SourceChannel.find(member_params[:source_channel_id])

  		@member.contact_details.update(contact_details_params)
  		@member.update(member_params)
  		@contact_details = @member.contact_details
  		
  		if @member.errors.none? and @member.contact_details.errors.none?
    		redirect_to @member
  		else
    		render 'edit'
  		end
	end

	def destroy
		@member = Member.find(params[:id])
		@member.destroy

		redirect_to members_path
	end

	private
		def member_params
			params.require(:member).permit(:membership_number, :forename, :surname, :notes, :signup_source, :member_category_id, :source_channel_id)
		end

	private
		def contact_details_params
			params.require(:contact_details).permit(:address_line_1, :address_line_2, :address_line_3, :town, :county, :postcode, :country, :telephone, :email)
		end
end
