class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable
  devise :confirmable, :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :campaigns, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :joined_campaigns, through: :enrollments, source: :campaign

  after_create :set_role

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

  # Omniauth

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  private
  def set_role
    self.add_role(:tweeter) if self.provider == 'twitter'
  end

end

