class Member < ActiveRecord::Base
  has_many :entitlement_periods, dependent: :destroy
  belongs_to :membership_status
  belongs_to :member_category
  belongs_to :source_channel
  has_one :contact_details, dependent: :destroy, autosave: true
  
  validates :forename, presence: true, length: {minimum: 1 }
  validates :surname, presence: true, length: {minimum: 2}
  validates :member_category, presence: true
end
