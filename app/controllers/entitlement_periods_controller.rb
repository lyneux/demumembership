class EntitlementPeriodsController < ApplicationController

	def new
		@member = Member.find(params[:member_id])
		@entitlement_period = EntitlementPeriod.new()
		@payment = Payment.new()
	end

	def create

		@member = Member.find(params[:member_id])	

		@entitlement_period = @member.entitlement_periods.build(entitlement_period_params)

		@entitlement_period.build_payment(payment_params)
		@payment = @entitlement_period.payment

		@entitlement_period.save
		
		if @entitlement_period.errors.any?
			render 'new'
		else
			redirect_to member_path(@member)
		end

	end

	def destroy
		@member = Member.find(params[:member_id])
		@entitlement_period = @member.entitlement_periods.find(params[:id])
		@entitlement_period.destroy
		redirect_to member_path(@member)
	end

	private
		def payment_params
			params.require(:payment).permit(:payment_date, :amount_in_pence)
		end

	private
		def entitlement_period_params
			params.require(:entitlement_period).permit(:endDate)
		end
	
end
