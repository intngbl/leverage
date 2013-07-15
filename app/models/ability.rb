class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all
    can :catalog, Campaign
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :agency
      can :manage, Campaign
      can [:authorize, :destroy, :update], Enrollment
    elsif user.has_role? :tweeter
      can [:create, :destroy], Enrollment
    end
  end

end
