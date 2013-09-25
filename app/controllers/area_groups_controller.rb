class AreaGroupsController < ApplicationController

	http_basic_authenticate_with name: "demu", password: "Ca5e5h0w"

	def new
		@area_group = AreaGroup.new()
	end

	def create
		@area_group = AreaGroup.new(area_group_params)
		@area_group.save

		if @area_group.errors.none?
			redirect_to @area_group
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
	end

	def update
		@area_group = AreaGroup.find(params[:id])
		@area_group.update(area_group_params)

		if @area_group.errors.none?
			redirect_to @area_group
		else
			render 'new'
		end
	end

	def destroy
		@area_group = AreaGroup.find(params[:id])
		@area_group.destroy
		redirect_to area_groups_path
	end

	private
		def area_group_params
			params.require(:area_group).permit(:name, :description, :active)
		end
end