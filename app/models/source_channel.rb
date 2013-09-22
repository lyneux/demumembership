class SourceChannel < ActiveRecord::Base
	has_many :member

	EXHIBITION = "exhibition"
	ONLINE = "online"
	SHOWCASE = "showcase"

	ALL_CHANNELS = [EXHIBITION, ONLINE, SHOWCASE]

	validates_inclusion_of :channel, :in => ALL_CHANNELS
end
