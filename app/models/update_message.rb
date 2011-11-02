class UpdateMessage < ActiveRecord::Base
  belongs_to :user    # the user who created the message
  validates :subject, :presence => true
  validates :user_id, :presence => true

  default_scope order("published_on DESC, updated_at DESC")
  scope :published, where("published_on IS NOT NULL")
end
