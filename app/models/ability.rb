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
        can :read, LopMonHoc do |lop|
            user.imageable.lop_mon_hocs.include?(lop)
        end 
        can :manage, ThongBaoLopHoc do |tb|
            user.imageable.lop_mon_hocs.include?(tb.lop_mon_hoc)
        end
        can [:read,:update], LopMonHocSinhVien do |lmh|
            user.imageable.lop_mon_hocs.include?(lmh.lop_mon_hoc)
        end
        can [:read, :create, :update], DiemDanh do |dd|
            user.imageable.lop_mon_hocs.include?(dd.lop_mon_hoc)
        end
        can [:read, :create, :update], LichTrinhGiangDay do |lt|
            user.imageable.lop_mon_hocs.include?(lt.lop_mon_hoc)
        end
        can :manage, Topic do |tp|
            user.imageable.lop_mon_hocs.include?(tp.lop_mon_hoc)
        end
        can :manage, Post do |p|
            user.imageable.lop_mon_hocs.include?(p.lop_mon_hoc)
        end
    end
    if user.role == 'trogiang'
        can :read, LopMonHoc do |lop|
            user.lop_mon_hocs.include?(lop)
        end 
        can :manage, ThongBaoLopHoc do |tb|
            user.lop_mon_hocs.include?(tb.lop_mon_hoc)
        end
        can [:read,:update], LopMonHocSinhVien do |lmh|
            user.lop_mon_hocs.include?(lmh.lop_mon_hoc)
        end
        can [:read, :create, :update], DiemDanh do |dd|
            user.lop_mon_hocs.include?(dd.lop_mon_hoc)
        end
        can [:read, :create, :update], LichTrinhGiangDay do |lt|
            user.lop_mon_hocs.include?(lt.lop_mon_hoc)
        end
        can :manage, Topic do |tp|
            user.lop_mon_hocs.include?(tp.lop_mon_hoc)
        end
        can :manage, Post do |p|
            user.lop_mon_hocs.include?(p.lop_mon_hoc)
        end
    end
    if user.role == 'sinhvien'
        can :read, LopMonHoc do |lop|
            user.imageable.lop_mon_hocs.include?(lop)
        end 
        can :read, ThongBaoLopHoc do |tb|
            user.imageable.lop_mon_hocs.include?(tb.lop_mon_hoc)
        end
        can :read, LopMonHocSinhVien do |lmh|
            user.imageable.lop_mon_hocs.include?(lmh.lop_mon_hoc)
        end
        can :read, DiemDanh do |dd|
            user.imageable.lop_mon_hocs.include?(dd.lop_mon_hoc)
        end
        can :read, LichTrinhGiangDay do |lt|
            user.imageable.lop_mon_hocs.include?(lt.lop_mon_hoc)
        end
        can :manage, Topic do |tp|
            user.imageable.lop_mon_hocs.include?(tp.lop_mon_hoc) and tp.user_id == user.id
        end
        can :manage, Post do |p|
            user.imageable.lop_mon_hocs.include?(p.lop_mon_hoc) and p.user_id == user..id
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
