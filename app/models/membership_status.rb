class MembershipStatus < ActiveRecord::Base
	has_many :member

	LIVE = "live"
	EXPIRED	 = "expired"
	DEAD = "dead"

	ALL_STATES = [LIVE, EXPIRED, DEAD]

	validates_inclusion_of :status, :in => ALL_STATES
end
