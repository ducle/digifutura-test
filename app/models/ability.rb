class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :manage, FileNode, :owner_id => user.id
    can :read, FileNode do |file_node|
      file_node.can_view_by_user?(user)
    end
  end
end
