# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MemberCategory.create(description: "Adult UK", price_in_pence_per_year: '2100')
MemberCategory.create(description: "OAP UK", price_in_pence_per_year: '1800')
MemberCategory.create(description: "Junior UK", price_in_pence_per_year: '1800')
MemberCategory.create(description: "Family UK", price_in_pence_per_year: '2300')
MemberCategory.create(description: "Rest of World", price_in_pence_per_year: '2800')

MembershipStatus.create(status: "live")
MembershipStatus.create(status: "expired")
MembershipStatus.create(status: "quit")

SourceChannel.create(channel: "exhibition")
SourceChannel.create(channel: "online")
SourceChannel.create(channel: "showcase")

PaymentMethod.create(payment_method: "cheque")
PaymentMethod.create(payment_method: "paypal")
PaymentMethod.create(payment_method: "direct debit")
PaymentMethod.create(payment_method: "bank transfer")
PaymentMethod.create(payment_method: "cash")

AreaGroup.create(name: "3CAG", description: "Three Counties: N Notts, N Derbs., S Yorks.", active: "true")
AreaGroup.create(name: "ANGLIA", description: "East Anglia", active: "true")
AreaGroup.create(name: "DCAG", description: "Devon and Cornwall", active: "true")
AreaGroup.create(name: "EMAG", description: "East Midlands", active: "true")
AreaGroup.create(name: "GMAG", description: "Greater Manchester", active: "true")
AreaGroup.create(name: "HBAG", description: "Hertfordshire and Bedfordshire", active: "true") #ACTUALLY FALSE BUT WONT IMPORT!
AreaGroup.create(name: "LAG", description: "London", active: "true")
AreaGroup.create(name: "Lincolnshire", description: "Lincolnshire", active: "true")
AreaGroup.create(name: "NEAG", description: "North East", active: "true")
AreaGroup.create(name: "NWAG", description: "North West", active: "true") #ACTUALLY FALSE BUT WONT IMPORT!
AreaGroup.create(name: "SCAG", description: "Solent & Coastway", active: "true")
AreaGroup.create(name: "Scotland", description: "Scotland (incl. SLAG and NOS?)", active: "true")
AreaGroup.create(name: "SWAG", description: "South West", active: "true")
AreaGroup.create(name: "WMAG", description: "West Midlands", active: "true")
AreaGroup.create(name: "WRAG", description: "White Rose (Yorkshire)", active: "true")

