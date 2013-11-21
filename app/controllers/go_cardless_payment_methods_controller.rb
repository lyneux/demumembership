class GoCardlessPaymentMethodsController < ApplicationController
	
	def new
		@member = Member.find(params[:member_id])

		redirect_uri = "http://" + request.host_with_port + member_go_cardless_payment_methods_create_path(@member)
		puts "Redirecting to gocardless with redirect URI back set to: " + redirect_uri

		url_params = {
			:amount          => 5000,
			:interval_unit   => "month",
			:interval_length => 1,
			:name            => "DEMU Subscription",
			:state           => @member.id,
			:redirect_uri    => redirect_uri,
			:user => {
				:first_name => @member.forename,
				:last_name => @member.surname,
				:email => @member.contact_details.email,
				:address_line_1 => @member.contact_details.address_line_1,
				:address_line_2 => @member.contact_details.address_line_2,
				:address_line_3 => @member.contact_details.town,
				:postal_code => @member.contact_details.postcode
			}
		}
		url = GoCardless.new_pre_authorization_url(url_params)
		redirect_to url
	end

	def create
		@member = Member.find(params[:state])

		@resource_id = params[:resource_id]

		@member.build_go_cardless_payment_method(:go_cardless_reference => @resource_id)

		renewal_type = SubscriptionRenewalType.find_by_description(SubscriptionRenewalType::DIRECT_DEBIT)
		@member.build_subscription(subscription_renewal_type: renewal_type) if @member.subscription.nil?
		@member.subscription.subscription_renewal_type = renewal_type
		@member.save

		GoCardless.confirm_resource params
			redirect_to member_path(@member), :flash => {:success => "Go Cardless Payment Method has now been registered"}
		rescue GoCardless::ApiError => e
			redirect_to member_path(@member), :flash => {:error => "Could not confirm Go Cardless Pre Authorization. Details: #{e}"}

	end
end
