class Product < ActiveRecord::Base
  belongs_to :user
  has_many :purchases
  has_many :buyers, :through => :purchases

  validates :product_name, presence: true, length: { in: 2..30 }
  validates :amount, presence: true, :numericality => { :greater_than => 0 }

end
