class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :manage, User
    can :manage, RecipeFood
    return unless user.present?

    can :read, Recipe, public: true
    can :manage, Recipe, user_id: user.id
    can :read, Food
    can :manage, Food, user_id: user.id
  end
end
