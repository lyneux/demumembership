class ForumDetails < ActiveRecord::Base
	belongs_to :member
	validates :forum_id, numericality: true, uniqueness: true
	validates :forum_name, length: {minimum: 2}, uniqueness: true
end
