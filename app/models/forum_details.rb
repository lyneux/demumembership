class ForumDetails < ActiveRecord::Base
	belongs_to :member
	validates :forum_id, numericality: true, uniqueness: true, allow_nil: true, allow_blank: true
	validates :forum_name, length: {minimum: 2}, uniqueness: true, allow_nil: true, allow_blank: true
end
