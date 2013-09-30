class MembersController < ApplicationController

	http_basic_authenticate_with name: "demu", password: "Ca5e5h0w"

	def new
		@member = Member.new(:date_added => Date.today)
		@contact_details = ContactDetails.new
		@forum_details = ForumDetails.new
		@max_member_id = Member.maximum("membership_number")
	end

	def create
		puts "Start"

		@member = Member.new(member_params)
		@member.member_category = MemberCategory.find(member_params[:member_category_id])
		unless member_params[:area_group_id].to_s == ''
			@member.area_group = AreaGroup.find(member_params[:area_group_id])
		end
		unless member_params[:source_channel_id].to_s == ''
			@member.source_channel = SourceChannel.find(member_params[:source_channel_id])
		end
		@member.membership_status = MembershipStatus.find_by_status(MembershipStatus::LIVE)
		
		puts "Pre-Contact Details"	
		@contact_details = ContactDetails.new(contact_details_params)
		@member.contact_details = @contact_details

		@forum_details = ForumDetails.new(forum_details_params)
		unless forum_details_params[:forum_id].blank?
			@member.forum_details = @forum_details
		end

		#Just in case there are other validation errors and we have to return to the page
		@max_member_id = Member.maximum("membership_number")

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
		@forum_details = @member.forum_details
		if @forum_details.nil?
			@forum_details = ForumDetails.new
		end
		@max_member_id = Member.maximum("membership_number")
	end
	
	def update

  		@member = Member.find(params[:id])
  		@member.member_category = MemberCategory.find(member_params[:member_category_id])
  		@member.area_group = AreaGroup.find(member_params[:area_group_id])
  		unless member_params[:source_channel_id].to_s == ''
  			@member.source_channel = SourceChannel.find(member_params[:source_channel_id]) 
  		end

  		@member.contact_details.update(contact_details_params)
  		
  		#If forum_details is not empty - assume we have forum details:
  		unless forum_details_params[:forum_id].blank?
  			@member.build_forum_details(forum_details_params)
  			@forum_details = @member.forum_details
  		end

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

	# NON-STANDARD METHODS
	def upcoming_renewals
		@number_of_days_until_expiry = params[:number_of_days_until_expiry]
  		targetDate = Date.today + params[:number_of_days_until_expiry].to_i.day
  		entitlements_expiring = EntitlementPeriod.where("end_date < ?", targetDate)#.where("end_date > ?", Date.today)
  		
  		@members = []
  		for entitlement in entitlements_expiring
  			@members.push(entitlement.member) if entitlement.member.membership_status == MembershipStatus.find_by_status(MembershipStatus::LIVE)
  		end

	end

	def expire
		entitlements_expiring = EntitlementPeriod.where("end_date < ?", Date.today)
		members = []
		live_status = MembershipStatus.find_by_status(MembershipStatus::LIVE)
		expired_status = MembershipStatus.find_by_status(MembershipStatus::EXPIRED)

		for entitlement in entitlements_expiring
			@member = Member.find(entitlement.member.id)
			if @member.membership_status == live_status
  				members.push(@member)
	  			@member.membership_status_id = expired_status.id
	  			@member.save
  			end
  			
  		end
  		render 'expire', :locals => { :members => members}
  	end

	private
		def member_params
			params.require(:member).permit(:membership_number, :forename, :surname, :date_of_birth, :notes, :signup_source, :member_category_id, :source_channel_id, :area_group_id)
		end

	private
		def contact_details_params
			params.require(:contact_details).permit(:address_line_1, :address_line_2, :address_line_3, :town, :county, :postcode, :country, :telephone, :email)
		end

	private
		def forum_details_params
			params.require(:forum_details).permit(:forum_id, :forum_name)
		end

	
end
