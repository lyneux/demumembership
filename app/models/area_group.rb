class AreaGroup < ActiveRecord::Base
	has_many :member
	validates :name, presence: true, length: {minimum: 3 }
  	validates :description, presence: true, length: {minimum: 5}
  	validates_inclusion_of :active, :in => [true, false]

  	def to_s
		name
	end
end
