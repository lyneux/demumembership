class Role < ActiveRecord::Base
	has_many :forum_details

	MEMBER = "member"
	AREA_GROUP_ADMIN = "area group admin"
	MEMBER_ADMIN = "member admin"

	ALL_ROLES = [MEMBER, AREA_GROUP_ADMIN, MEMBER_ADMIN]

	validates_inclusion_of :description, :in => ALL_ROLES

	def to_s
		description
	end
end
