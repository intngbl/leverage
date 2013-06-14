class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :agency
      can :manage, Campaign
    end
  end

end
