class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :campaigns, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :joined_campaigns, through: :enrollments, source: :campaign

  def joined?(campaign)
    enrollments.find_by_campaign_id(campaign.id).present?
  end

  def join!(campaign)
    enrollments.create!(campaign_id: campaign.id)
  end

  def leave!(campaign)
    enrollments.find_by_campaign_id(campaign).destroy
  rescue ActiveRecord::RecordNotFound
    return false
  end

end
