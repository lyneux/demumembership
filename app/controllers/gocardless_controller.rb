class GocardlessController < ApplicationController

    http_basic_authenticate_with name: "demu", password: "Ca5e5h0w"

  	def step1
  		@member = Member.new
  	end

  	def step1_submit
  		@member = Member.find_by_membership_number(params[:id])
  		if @member.nil?
  			render 'step1'
  		else
  			redirect_to gocardless_step2_path(@member)
  		end
  	end

  	def step2
  		@member = Member.find(params[:member_id])
  	end

    def step2_submit

      @member = Member.find(params[:member_id])

      unless Date.today.day == 1
        @start_at = Date.new(Date.today.year, Date.today.next_month.month, 1)
      end

      url_params = {
        :amount          => @member.member_category.price_in_pence_per_year/100,
        :interval_unit   => "month",
        :interval_length => 12,
        :name            => "DEMU Subscription: " + @member.member_category.description,
        :state           => @member.id,
        :start_at        => @start_at,
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
      url = GoCardless.new_subscription_url(url_params)
      redirect_to url
    end

    def confirm
      @member = Member.find(params[:state])

      @resource_id = params[:resource_id]

      @member.build_subscription(:go_cardless_reference => @resource_id)
      #@member.subscription.go_cardless_reference = @resource_id
      @member.save

      GoCardless.confirm_resource params
        render "gocardless/success"
      rescue GoCardless::ApiError => e
        render :text => "Could not confirm new subscription. Details: #{e}"
    end

	private
		def member_params
			params.require(:member).permit(:id)
		end

end
