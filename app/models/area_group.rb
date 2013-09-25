class AreaGroup < ActiveRecord::Base
	has_many :members
	has_one :coordinator, class_name: "Member", foreign_key: "area_group_coordinator_id"

	validates :name, presence: true, length: {minimum: 3 }
  	validates :description, presence: true, length: {minimum: 5}
  	validates_inclusion_of :active, :in => [true, false]

  	def to_s
		name
	end
end
