class Member < ActiveRecord::Base
  has_many :entitlement_periods, dependent: :destroy
  belongs_to :membership_status
  belongs_to :member_category
  belongs_to :source_channel
  belongs_to :area_group
  has_one :contact_details, dependent: :destroy, autosave: true
  has_one :forum_details, dependent: :destroy, autosave: true
  
  validates :forename, presence: true, length: {minimum: 1 }
  validates :surname, presence: true, length: {minimum: 2}
  validates :member_category, presence: true
  validates :membership_number, presence: true, numericality: true, uniqueness: true
  validates :contact_details, presence: true

  def find_latest_entitlement
    entitlement_periods.last unless entitlement_periods.nil?
  end

  def paid_up_to_date
    if find_latest_entitlement.nil?
      'none'
    else
      find_latest_entitlement.end_date.to_s()
    end
  end

  def to_s
    forename + " " + surname
  end

  def expire
    membership_status = MembershipStatus.find_by_status(MembershipStatus::EXPIRED)
  end
  
end
