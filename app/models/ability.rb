class Ability
  include CanCan::Ability

  def initialize(user) 
    user ||= User.new   
    #can :read, :all
    if user.is_admin?
        can :manage, :all
        can :read, ActiveAdmin::Page, :name => "Dashboard"
    end
    if user.role == 'giangvien'
        can :read, LopMonHoc, :ma_giang_vien => user.imageable.code
        can :manage, ThongBaoLopHoc, ["order by created_at"] do |tb|
            user.imageable.lop_mon_hocs.map(&:id).include?(tb.lop_mon_hoc.id)
        end
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
