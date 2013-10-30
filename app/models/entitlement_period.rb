class EntitlementPeriod < ActiveRecord::Base
  belongs_to :member

  has_one :payment, autosave: true, as: :payable

  validates :end_date, presence: true
  #validate :check_if_last_month_of_current_entitlement

  def check_if_last_month_of_current_entitlement
  	latest_entitlement = member.find_latest_entitlement unless member.nil?
  	unless latest_entitlement.nil?
  		unless (Date.today.next_month > latest_entitlement.end_date)
  			errors.add(:entitlement_period, "cannot be created because you are not in the last month of the current entitlement")
  		end
  	end
  end

  def last
    self == self.member.entitlement_periods.last
  end

end
