class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates :email, :presence => { :on => :create }
  validates :password, :presence => { :on => :create }

  belongs_to :last_read_message, :class_name => 'UpdateMessage'

  def update_last_read_message(message)
    return unless message.published_on
    unless last_read_message and last_read_message.published_on > message.published_on
      self.last_read_message = message
      self.save
    end
  end
end
