class MemberCategory < ActiveRecord::Base
	has_many :member

	def formatted_description
		description + " (£" + (price_in_pence_per_year.to_i/100).to_s + " per year)"
	end

end
