class Post < ActiveRecord::Base
	acts_as_votable
	validates :image, presence: true
	paginates_per 3
	validates :caption, length: {minimun: 3, maximum: 300}
	has_attached_file :image, styles: { :medium => "640x" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	belongs_to :user
	has_many :comments
	has_many :notifications, dependent: :destroy  
end
