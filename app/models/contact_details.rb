class ContactDetails < ActiveRecord::Base
	belongs_to :member

	validates :address_line_1, presence: true, length: {minimum: 2}
	validates :town, presence: true, length: {minimum: 2}
	validates :country, length: {minimum: 2}
	validates :postcode, presence: true, length: {minimum: 6}, if: :isuk?
	validates :telephone, allow_blank: true, length: {minimum: 10}, numericality: true
	validates :email, allow_blank: true, length: {minimum: 3}
	validates_format_of :email, allow_blank: true, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates_format_of :postcode, :with =>  /\A([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\s?[0-9][ABD-HJLNP-UW-Z]{2}|(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))\z\z/i, :message => "invalid postcode", if: :isuk?

	def isuk?
		country.eql?('United Kingdom')
	end

end
