class Campaign < ActiveRecord::Base
  attr_accessible :brief, :price, :title
  belongs_to :user

  validates :title, presence: true, length: { maximum: 140 }
  validates :brief, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order: 'campaigns.created_at DESC'
end
