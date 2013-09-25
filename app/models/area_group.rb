class AreaGroup < ActiveRecord::Base
	has_many :member
	validates :name, presence: true, length: {minimum: 3 }
  	validates :description, presence: true, length: {minimum: 5}
  	validates :active, presence: true

  	def to_s
		name
	end
end
