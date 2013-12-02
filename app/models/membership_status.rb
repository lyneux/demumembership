class MembershipStatus < ActiveRecord::Base
	has_many :member

	NEW = "new"
	LIVE = "live"
	EXPIRED	 = "expired"
	QUIT = "quit"

	ALL_STATES = [NEW, LIVE, EXPIRED, QUIT]

	validates_inclusion_of :status, :in => ALL_STATES

	def to_s
		status
	end
end
