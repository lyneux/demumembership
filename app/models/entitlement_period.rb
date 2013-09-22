class EntitlementPeriod < ActiveRecord::Base
  belongs_to :member
  validates :endDate, presence: true
end
