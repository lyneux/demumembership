module AreaGroupsHelper
	def selected_coordinator_id(area_group)
		if area_group.coordinator.nil?
			return ''
		else
			return area_group.coordinator.id
		end
	end
end
