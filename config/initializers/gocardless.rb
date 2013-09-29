# In config/initializers/gocardless.rb
# (you'll need to create this file)

# We're using the sandbox environment for testing
GoCardless.environment = :sandbox

GoCardless.account_details = {
  :app_id      => 'DQG0YM2FB20Q871YNG9ZCHBHHQ4RAARSWSCREC80F5TZ3WWHY3MDW52CA1P426D5',
  :app_secret  => 'SBEDDNC3A1H3QH4PKSYW6XZNX5WW36CZRMPZEF55H32ABSE50HX83MMP63EG3WG1',
  :token       => 'R6FWBGNSA65MWA0TRJ5EV0TKXP36CZT93R78W16TF44YA2H1X8VV14TZM7AHGHGX',
  :merchant_id => '0EC54RKCW1'
}