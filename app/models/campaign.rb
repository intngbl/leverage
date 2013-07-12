class Campaign < ActiveRecord::Base
  attr_accessible :brief, :price, :title
  belongs_to :user
  has_many :enrollments, dependent: :destroy
  has_many :joined_users, through: :enrollments, source: :user

  validates :title, presence: true, length: { maximum: 140 }
  validates :brief, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order: 'campaigns.created_at DESC'
  scope :latest, -> { limit(3) }
end
