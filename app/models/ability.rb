class Ability
  include CanCan::Ability

  def initialize(user) 
    user ||= User.new   
    #can :read, :all
    
    if user.is_admin?
        can :manage, :all     
         can :read, ActiveAdmin::Page, :name => "Dashboard"  
    end
    if user.imageable.is_a?(GiangVien) or user.role == 'trogiang'     
        can :read, SinhVien           
        can :manage, LopMonHoc do |lop|
          user.code == lop.ma_giang_vien or user.id == lop.user_id
        end
        can :manage, LichTrinhGiangDay do |lich|
            can? :manage, lich.lop_mon_hoc or (user.code == lich.ma_giang_vien_moi and lich.status == 3)
        end  
        cannot :quanly, LichTrinhGiangDay do |lich|
            cannot? :manage, lich
        end      
        can :nghitiet, LichTrinhGiangDay do |lich|
            (can :manage, lich) and (lich.ngay_day.localtime <= DateTime.now) and (lich.ngay_day.localtime + (lich.so_tiet_day * 45).minutes >= DateTime.now)
        end
        cannot :diemdanh, LichTrinhGiangDay do |l|
            [1,2,3,4].include?(l.loai) and l.status == 6
        end
        can :manage, ThongBaoLopHoc do |tb|
            user.imageable.lop_mon_hocs.map(&:id).include?(tb.lop_mon_hoc.id) if user.imageable.is_a?(GiangVien)
            user.lop_mon_hocs.map(&:id).include?(tb.lop_mon_hoc.id) if user.role == 'trogiang'
        end
        can :manage, DiemDanh do |dd|
            can? :manage, dd.lich_trinh_giang_day
        end        
        
    end
    if user.imageable.is_a?(SinhVien)      
        can :read, SinhVien  
        can [:read, :rate], LichTrinhGiangDay do |lich|
           user.imageable.lop_mon_hocs.map(&:id).include?(lich.lop_mon_hoc.id) and lich.lop_mon_hoc and lich.ngay_day.localtime <= Time.now  if user.imageable.is_a?(SinhVien)
        end
        can :read, LopMonHoc do |lop|
            user.imageable.lop_mon_hocs.map(&:id).include?(lop.id) if user.imageable.is_a?(SinhVien) if lop
        end
    end
    if user.groups.count > 0 and user.groups.map(&:name).include?("daotao")        
        can :manage, LopMonHocSinhVien
        can :manage, LichTrinhGiangDay
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
