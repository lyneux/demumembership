class ForumDetails < ActiveRecord::Base
	belongs_to :member
	belongs_to :role
	
	validates :forum_id, numericality: true, uniqueness: true, allow_nil: true, allow_blank: true
	validates :forum_name, length: {minimum: 2}, uniqueness: true, allow_nil: true, allow_blank: true

	before_create :create_remember_token

	def ForumDetails.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def ForumDetails.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def authenticate(unencrypted_password)
		puts "authenticating user"
		puts "unencrypted_password:" + unencrypted_password
		puts "digest of unencrypted_password:" + Digest::SHA1.hexdigest(forum_name + unencrypted_password)
		puts "forum_name:" + forum_name
		puts "forum_password:" + forum_password
		forum_password == Digest::SHA1.hexdigest(forum_name + unencrypted_password)
	end

	private

		def create_remember_token
			self.remember_token = ForumDetails.encrypt(ForumDetails.new_remember_token)
		end
end
