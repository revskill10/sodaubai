select tuan, string_agg(noi_dung_day, '\r\n ') as noidung, sum(so_tiet_day_moi) as sotiet, 

string_agg(to_char(ngay_day,'DD/MM/YYYY') ||
	case when ngay_day_moi is not null then
		 '(' || to_char(ngay_day_moi,'DD/MM/YYYY') || ')'
	else
		''
	end
 , '\r\n ') 

as ngayday

from t1.lich_trinh_giang_days
where lop_mon_hoc_id=#{@lop_mon_hoc.id}
and destroyed_at is null
group by tuan
order by tuan
