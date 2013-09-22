# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MemberCategory.create(description: "Adult UK", price_in_pence_per_year: '2100')
MemberCategory.create(description: "OAP/Junior UK", price_in_pence_per_year: '1800')
MemberCategory.create(description: "Family UK", price_in_pence_per_year: '2300')
MemberCategory.create(description: "Rest of World", price_in_pence_per_year: '2800')

MembershipStatus.create(status: "live")
MembershipStatus.create(status: "expired")
MembershipStatus.create(status: "dead")

SourceChannel.create(channel: "exhibition")
SourceChannel.create(channel: "online")
SourceChannel.create(channel: "showcase")

PaymentMethod.create(payment_method: "cheque")
PaymentMethod.create(payment_method: "paypal")
PaymentMethod.create(payment_method: "direct debit")
PaymentMethod.create(payment_method: "bank transfer")
PaymentMethod.create(payment_method: "cash")
