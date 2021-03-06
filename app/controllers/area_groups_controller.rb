class AreaGroupsController < ApplicationController

	before_action :signed_in_member
	before_action :area_group_admin,   only: [:edit, :update, :new, :create, :destroy]

	def new
		@area_group = AreaGroup.new()
		@people = @area_group.members.sort_by!{ |m| m.forename.downcase }
	end

	def create
		@area_group = AreaGroup.new(area_group_params)
		@people = @area_group.members.sort_by!{ |m| m.forename.downcase }
		@area_group.save

		if @area_group.errors.none?
			redirect_to @area_group, :flash => {:success => "Area group created"}
		else
			render 'new'
		end
	end

	def show
		@area_group = AreaGroup.find(params[:id])
	end

	def index
  		@area_groups = AreaGroup.all
	end

	def edit
		@area_group = AreaGroup.find(params[:id])
		@people = @area_group.members.sort_by!{ |m| m.forename.downcase }
	end

	def update
		@area_group = AreaGroup.find(params[:id])
		@area_group.update_attributes(area_group_params)
		@people = @area_group.members.sort_by!{ |m| m.forename.downcase }

		if @area_group.errors.none?
			redirect_to @area_group
		else
			render 'new'
		end
	end

	def destroy
		@area_group = AreaGroup.find(params[:id])
		@area_group.destroy
		redirect_to area_groups_path, :flash => {:success => "Area group removed"}
	end

	private
		def area_group_params
			params.require(:area_group).permit(:name, :description, :active, :coordinator_id)
		end

		def signed_in_member
      		redirect_to signin_url, :flash => {:danger => "Please sign in."} unless signed_in?
    	end

		def area_group_admin
    		redirect_to area_groups_path, :flash => {:danger => "You are not allowed to perform that operation"} unless area_group_admin?
    	end
end
