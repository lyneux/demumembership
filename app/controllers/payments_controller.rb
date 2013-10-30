class PaymentsController < ApplicationController
	protect_from_forgery except: :handle_notification

	def create_dd_payments
  		entitlements_expiring_soon = EntitlementPeriod.where("end_date < ?", Date.today + 7.day)
  		members = []

		for entitlement in entitlements_expiring_soon
			member = Member.find(entitlement.member.id)
			payment_date = entitlement.end_date
			direct_debit_renewal_type = SubscriptionRenewalType.find_by_description(SubscriptionRenewalType::DIRECT_DEBIT)
			if member.subscription.subscription_renewal_type == direct_debit_renewal_type
				
				# Only request payments if there isn't already a pending one:
				unless member.has_pending_payment
					puts "Using Go Cardless Pre-Auth=" + member.go_cardless_payment_method.go_cardless_reference
					pre_auth = GoCardless::PreAuthorization.find(member.go_cardless_payment_method.go_cardless_reference)
					bill = pre_auth.create_bill(:name => member.member_category.description, :amount => (member.member_category.price_in_pence_per_year.to_f/100), :charge_customer_at => payment_date)
					puts "BILL=" + bill.to_yaml

					paymentdata = {amount_in_pence: (member.member_category.price_in_pence_per_year), payment_date: payment_date}
        			paymentdata[:payment_status] = PaymentStatus.find_by_description('pending')
        			paymentdata[:member_id] = member.id
        			paymentdata[:payment_type] = PaymentType.find_by_description('direct debit')
        			paymentdata[:go_cardless_reference] = bill.id.to_s
					member.payments.build(paymentdata)
					if member.save
						members.push(member)
					end
					
				end

			end
  		end

  		render 'dd_payments_requested', :locals => { :members => members}
  	end

  	def handle_notification
		if GoCardless.webhook_valid?(params[:payload])
			render :text => "true", :status => 200
			data = params[:payload]
			if data[:resource_type] == "bill"
				data[:bills].each do |bill|
					puts "BILL=" + bill.to_yaml
					puts "ACTION=" + data[:action]
					payment = Payment.find_by_go_cardless_reference(bill[:id])
					case data[:action]
					when 'created'
						#IGNORE
					when 'paid'
						payment.paid
						payment.member.add_entitlement_period(payment)
					when 'withdrawn'
						#IGNORE
					when 'failed'
						payment.failed
					when 'refunded'
						payment.refunded
					when 'chargedback'
						payment.chargedback
						payment.member.revoke_entitlement_period(payment)
					when 'retried'
						payment.retried
					else
						puts "Unknown status=" + bill.status
					end
				end
			end
		else
			render :text => "false", :status => 403
		end
	end

	def test_handle_notification
		payment = Payment.find_by_go_cardless_reference('0FFMYHSJKH')
		
		payment.paid
		payment.member.add_entitlement_period(payment)

		#payment.chargedback
		#payment.member.revoke_entitlement_period(payment)

		puts "MEMBER STATUS = " + payment.member.membership_status.to_s
		redirect_to member_path(payment.member)

	end

	private
		def create_entitlement

		end
end
