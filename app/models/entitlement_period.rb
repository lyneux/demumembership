class EntitlementPeriod < ActiveRecord::Base
  belongs_to :member

  has_one :payment, dependent: :destroy, autosave: true, as: :payable

  validates :endDate, presence: true
  validates :payment, presence: true
  validate :check_if_last_month_of_current_entitlement

  def check_if_last_month_of_current_entitlement
  	latest_entitlement = member.find_latest_entitlement
  	unless latest_entitlement.nil?
  		unless (Date.today.next_month > latest_entitlement.endDate)
  			errors.add(:entitlement_period, "cannot be created because you are not in the last month of the current entitlement")
  		end
  	end
  end

  # Either works out the end date based on the current entitlement period or
  # adds a year to the current date
  def calculate_next_end_date(member)
  	latest_entitlement = member.find_latest_entitlement
  	if latest_entitlement.nil?
  		Date.new(Date.today.next_year.year, Date.today.next_month.month, 1)
  	else
  		latest_entitlement.endDate.next_year
  	end
  end

end
