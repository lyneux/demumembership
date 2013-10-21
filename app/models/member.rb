class Member < ActiveRecord::Base
  has_many :entitlement_periods, dependent: :destroy
  has_many :payments, dependent: :destroy
  belongs_to :membership_status
  belongs_to :member_category
  belongs_to :source_channel
  belongs_to :area_group
  has_one :contact_details, dependent: :destroy, autosave: true
  has_one :forum_details, dependent: :destroy, autosave: true
  has_one :subscription, dependent: :destroy, autosave: true
  has_one :go_cardless_payment_method, dependent: :destroy, autosave: true, as: :payment_methodable
  
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

  def member_admin?
    forum_details.role == Role.find_by_description(Role::MEMBER_ADMIN)
  end

  def area_group_admin?
    forum_details.role == Role.find_by_description(Role::AREA_GROUP_ADMIN)
  end

  def has_pending_payment
    pending = false
    for payment in payments
      pending_status = PaymentStatus.find_by_description(PaymentStatus::PENDING)
      if payment.payment_status == pending_status
        pending = true
      end
    end
    pending
  end

end
