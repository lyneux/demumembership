class Member < ActiveRecord::Base
  has_many :entitlement_periods, dependent: :destroy
  belongs_to :membership_status
  belongs_to :member_category
  belongs_to :source_channel
  has_one :contact_details, dependent: :destroy, autosave: true
  has_one :forum_details, dependent: :destroy, autosave: true
  
  validates :forename, presence: true, length: {minimum: 1 }
  validates :surname, presence: true, length: {minimum: 2}
  validates :member_category, presence: true
  validates :membership_number, presence: true, numericality: true, uniqueness: true

  def find_latest_entitlement
    entitlement_periods.last
  end

  def paid_up_to_date
    if find_latest_entitlement.nil?
      'none'
    else
      find_latest_entitlement.endDate.to_s()
    end
  end
end
