class User < ActiveRecord::Base
  has_secure_password
  has_many :purchases, :foreign_key => "user_id", :class_name => "Purchase"
  has_many :buyers, :through => :purchases

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true, length: { in: 2..30 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8 }

  before_save :lowercase

  def lowercase
    email.downcase!
  end

end
