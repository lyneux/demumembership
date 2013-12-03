class MemberCategory < ActiveRecord::Base
	has_many :member

	def formatted_description
		result = description + " (" + "&pound;" + (price_in_pence_per_year.to_i/100).to_s + " per year)"
		result.html_safe
	end

end
