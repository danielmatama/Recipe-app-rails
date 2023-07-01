class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    return unless user.present?

    can :read, User
    can :manage, User
    can :read, Recipe, public: true
    can :manage, Recipe, user_id: user.id
    can :read, Food
    can :manage, Food, user_id: user.id
    can :manage, RecipeFood
  end
end
