class EntitlementPeriod < ActiveRecord::Base
  belongs_to :member

  has_one :payment, dependent: :destroy, autosave: true, as: :payable

  validates :endDate, presence: true
  validates :payment, presence: true

end
