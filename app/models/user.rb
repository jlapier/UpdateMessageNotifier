class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates :email, :presence => { :on => :create }
  validates :password, :presence => { :on => :create }
end
