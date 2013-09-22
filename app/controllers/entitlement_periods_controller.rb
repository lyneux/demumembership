class EntitlementPeriodsController < ApplicationController

	def create

		@member = Member.find(params[:member_id])	

		@entitlement_period = @member.entitlement_periods.create(params[:entitlement_period].permit(:endDate))
		if @entitlement_period.errors.any?
			render "members/show"
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
	
end
