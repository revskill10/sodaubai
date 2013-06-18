class DashboardController < ApplicationController
  
  before_filter :load_lops
  def index

  end
  
  protected
  def load_lops
  	@current_lops = [] unless current_user.imageable  	
  	@current_lops = current_user.imageable.lop_mon_hocs if current_user.imageable	
    
  	@globallich = {}
    @g2 = {}
    @max = {}
  	if current_user.imageable.is_a?(GiangVien) then 
      tuans = current_user.imageable.tkb_giang_viens.tuans     

      if tuans then         
        tuans.each do |k,v|          
          @globallich[k] = []
      		@current_lops.each do |li|
        	  @tkbs = li.tkb_giang_viens.with_tuan(k).map {|t| 
              {:size =>  t.schedule.all_occurrences.count,:thu => t.thu, :lop => li.id, :lich => t.schedule.all_occurrences }
            }                                	              
            @globallich[k] += @tkbs		  
          end	          
        end           
      end

    @max = {}
     @globallich.each do |k,v|
        @g2[k] = {}
        @max[k] = 0
        v.each do |f| 
          @g2[k][f[:thu]] = []
          @g2[k][f[:thu]] += f[:lich].map {|t| {:lop => f[:lop], :lich => t}}
          if @max[k] < f[:size] then @max[k] = f[:size] end 
        end      
     end

     @g2.each do |k,v|
        v.each do |i,j|
          if j.count < @max[k] then 
            (j.count .. @max[k]-1).each do |t|
                j[t] = nil
            end
          end
        end
     end
     @g3 = {}
     @g2.each do |k,v|
        @g3[k] = []
        v.each do |i,j|
          @g3[k] << j
        end        
     end
      @g4 = {}
      @g3.each do |k,v|
        @g4[k] = []
        @g4[k] << v.transpose
      end
    end
      
  end
end
