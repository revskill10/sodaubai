class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all    
    if user and user.has_role? :admin
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
    else
        can :read, LopMonHoc, :ma_lop => LopMonHoc.with_role(:giangvien, user).map(&:ma_lop) 
        can :read, LopMonHoc, :ma_lop => LopMonHoc.with_role(:sinhvien, user).map(&:ma_lop)
        can :manage, LichTrinhGiangDay, :ma_lop => LopMonHoc.with_role(:giangvien, user).map(&:ma_lop)
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
