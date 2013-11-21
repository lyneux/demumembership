class EntitlementPeriodsController < ApplicationController

	before_action :signed_in_member
	before_action :member_admin
	before_action :last_entitlement, only: [:destroy]
	
	def new
		@member = Member.find(params[:member_id])
		@entitlement_period = EntitlementPeriod.new()
		@payment = Payment.new()

		# Help out by settings some defaults:
		@payment.payment_date = Date.today
		@payment.amount_in_pence = @member.member_category.price_in_pence_per_year
		@entitlement_period.end_date = @member.calculate_next_entitlement_period_end_date
	end

	def create

		@member = Member.find(params[:member_id])	

		@entitlement_period = @member.entitlement_periods.build(entitlement_period_params)

		@entitlement_period.build_payment(payment_params)
		@payment = @entitlement_period.payment
		@payment.payment_type= PaymentType.find(payment_params[:payment_type_id])
		@payment.payment_status = PaymentStatus.find_by_description('complete')
		@payment.member = @member

		@entitlement_period.save
		@member.recalculate_status

		if @entitlement_period.errors.any?
			render 'new'
		else
			redirect_to member_path(@member), :flash => {:success => "Added membership period and payment"}
		end

	end

	
	def destroy
		entitlement_period = EntitlementPeriod.find(params[:id])
		entitlement_period.destroy
		@member = Member.find(params[:member_id])
		@member.recalculate_status
		redirect_to member_path(@member), :flash => {:success => "Latest membership period removed"}
	end

	private
		def payment_params
			params.require(:payment).permit(:payment_date, :amount_in_pence, :payment_type_id)
		end

		def entitlement_period_params
			params.require(:entitlement_period).permit(:end_date)
		end

		def signed_in_member
      		redirect_to signin_url, :flash => {:danger => "Please sign in."} unless signed_in?
    	end

		def member_admin
    		redirect_to member_url(params[:member_id]), :flash => {:danger => "You are not allowed to perform that operation"} unless member_admin?
    	end

    	def last_entitlement
    		entitlement_period = EntitlementPeriod.find(params[:id])
    		redirect_to member_url(params[:member_id]), :flash => {:danger => "Only the last entitlement can be removed"} unless entitlement_period.last
    	end


	
end
