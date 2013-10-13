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

PaymentType.create(description: "cheque")
PaymentType.create(description: "paypal")
PaymentType.create(description: "direct debit")
PaymentType.create(description: "bank transfer")
PaymentType.create(description: "cash")

AreaGroup.create(name: "3CAG", description: "Three Counties: N Notts, N Derbs., S Yorks.", active: "true")
AreaGroup.create(name: "ANGLIA", description: "East Anglia", active: "true")
AreaGroup.create(name: "DCAG", description: "Devon and Cornwall", active: "true")
AreaGroup.create(name: "EMAG", description: "East Midlands", active: "true")
AreaGroup.create(name: "GMAG", description: "Greater Manchester", active: "true")
AreaGroup.create(name: "Overseas", description: "Overseas (Not British Isles)", active: "false")
AreaGroup.create(name: "Ireland", description: "Ireland", active: "false")
AreaGroup.create(name: "LAG", description: "London", active: "true")
AreaGroup.create(name: "Lincolnshire", description: "Lincolnshire", active: "true")
AreaGroup.create(name: "NEAG", description: "North East", active: "true")
AreaGroup.create(name: "SCAG", description: "Solent & Coastway", active: "true")
AreaGroup.create(name: "Scotland", description: "Scotland (incl. SLAG and NOS?)", active: "true")
AreaGroup.create(name: "SWAG", description: "South West", active: "true")
AreaGroup.create(name: "Wales", description: "Wales", active: "false")
AreaGroup.create(name: "WMAG", description: "West Midlands", active: "true")
AreaGroup.create(name: "WRAG", description: "White Rose (Yorkshire)", active: "true")

Role.create(description: "member")
Role.create(description: "area group admin")
Role.create(description: "member admin")

SubscriptionRenewalType.create(description: "manual")
SubscriptionRenewalType.create(description: "direct debit")