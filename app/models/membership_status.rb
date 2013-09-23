class MembershipStatus < ActiveRecord::Base
	has_many :member

	LIVE = "live"
	EXPIRED	 = "expired"
	QUIT = "quit"

	ALL_STATES = [LIVE, EXPIRED, QUIT]

	validates_inclusion_of :status, :in => ALL_STATES
end
