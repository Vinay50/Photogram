class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable, :validatable
	validates :username, presence: true, length: {minimum: 4, maximum:16} 
	has_many :posts, dependent: :destroy    
	has_many :comments, dependent: :destroy 
	has_attached_file :avatar, styles: { medium: '152x152#' }  
      validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/ 
end
