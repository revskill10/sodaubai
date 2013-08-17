class Ability
  include CanCan::Ability

  def initialize(user) 
    user ||= User.new   
    #can :read, :all
    can :read, ActiveAdmin::Page, :name => "Dashboard"    
    if user.is_admin?
        can :manage, :all       
    end
    if user.imageable.is_a?(GiangVien) or user.role == 'trogiang'        
        can :manage, LopMonHoc,["id > 0"] do |lop|
          user.code == lop.ma_giang_vien or user.id == lop.user_id
        end
        can :manage, ThongBaoLopHoc, ["id > 0"] do |tb|
            user.imageable.lop_mon_hocs.map(&:id).include?(tb.lop_mon_hoc.id) if user.imageable.is_a?(GiangVien)
            user.lop_mon_hocs.map(&:id).include?(tb.lop_mon_hoc.id) if user.role == 'trogiang'
        end
        can :manage, DiemDanh, ["id > 0"] do |dd|
            user.imageable.lop_mon_hocs.map(&:id).include?(dd.lop_mon_hoc.id) if user.imageable.is_a?(GiangVien)
            user.lop_mon_hocs.map(&:id).include?(dd.lop_mon_hoc.id) if user.role == 'trogiang'
        end
    end
    if user.imageable.is_a?(SinhVien)        
        can [:read, :rate], LopMonHoc, ["id > 0"] do |lop|
            user.imageable.lop_mon_hocs.map(&:id).include?(lop.id) if user.imageable.is_a?(SinhVien) if lop
        end
    end
    if user.groups.count > 0 and user.groups.map(&:name).include?("daotao")        
        can :manage, LopMonHocSinhVien
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
