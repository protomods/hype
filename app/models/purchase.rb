class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :buyer, :foreign_key => "buyer_id", :class_name => "User"
  belongs_to :user, :foreign_key => "user_id", :class_name => "User"
end
