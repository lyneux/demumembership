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

  def activate
    puts 'Activating member:' + id.to_s
    self.membership_status = MembershipStatus.find_by_status(MembershipStatus::LIVE)
    self.save
  end

  def expire
    puts 'Expiring member:' + id.to_s
    self.membership_status = MembershipStatus.find_by_status(MembershipStatus::EXPIRED)
    self.save
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

  def add_entitlement_period(payment)
    # Only add an entitlement period if the payment is not linked to one already
    if payment.payable.nil?
      puts "starting creating entitlement period"

      entitlementdata = {end_date: calculate_next_entitlement_period_end_date}
      entitlement_period = entitlement_periods.build(entitlementdata)
    
      entitlement_period.member = self
      entitlement_period.payment = payment

      puts "saving entitlement period"
      entitlement_period.save
      
      puts "finished creating entitlement period"

      puts entitlement_period.errors.to_yaml

      self.activate
      self.save
    else
      puts "An entitlement period already exists for this payment"
    end
  end


  def revoke_entitlement_period(payment)
    unless payment.payable.nil?
      payment.payable.destroy
    end
    puts "Entitlement period removed from payment with id: " + payment.id.to_s
    recalculate_status
  end

  def recalculate_status
    expire_member = true
    for entitlement in entitlement_periods
      expire_member = false if entitlement.end_date > Date.today
    end
    if expire_member
      expire
    else
      activate
    end
  end

  # Either works out the end date based on the current entitlement period or
  # adds a year to the current date
  def calculate_next_entitlement_period_end_date()
    latest_entitlement = find_latest_entitlement
    if latest_entitlement.nil?
      Date.new(Date.today.next_year.year, Date.today.next_month.month, 1)
    else
      latest_entitlement.end_date.next_year
    end
  end
  
end
