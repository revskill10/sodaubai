select row_number() OVER(ORDER BY t.ten, t.ho_dem, t.ho) as "stt", t."msv",
concat(t."ho" ,' ', t.ho_dem,' ', t.ten) as "hovaten",  to_char(t.ngay_sinh,'DD/MM/YYYY' ) as "ngaysinh",
case when t."T1"=0 then NULL else t."T1" end as "T1", case when t."T2"=0 then NULL else t."T2" end as "T2", 
case when t."T3"=0 then NULL else t."T3" end as "T3", case when t."T4"=0 then NULL else t."T4" end as "T4",
case when t."T5"=0 then NULL else t."T5" end as "T5", case when t."T6"=0 then NULL else t."T6" end as "T6", 
case when t."T7"=0 then NULL else t."T7" end as "T7", case when t."T8"=0 then NULL else t."T8" end as "T8", 
case when t."T9"=0 then NULL else t."T9" end as "T9", case when t."T10"=0 then NULL else t."T10" end as "T10", 
case when t."T11"=0 then NULL else t."T11" end as "T11", case when t."T12"=0 then NULL else t."T12" end as "T12",
case when t."T13"=0 then NULL else t."T13" end as "T13", case when t."T14"=0 then NULL else t."T14" end as "T14",
case when t."T15"=0 then NULL else t."T15" end as "T15", case when t."T16"=0 then NULL else t."T16" end as "T16",
COALESCE("T1",0) + COALESCE("T2",0)+ COALESCE("T3",0)+ COALESCE("T4",0)
    + COALESCE("T5",0)+ COALESCE("T6",0)+ COALESCE("T7",0)+ COALESCE("T8",0)+ COALESCE("T9",0)+ COALESCE("T10",0)
    + COALESCE("T11",0)+ COALESCE("T12",0)+ COALESCE("T13",0)+ COALESCE("T14",0)+ COALESCE("T15",0)
    + COALESCE("T16",0) as tonggiovang, t.diemchuyencan, t.diemthuchanh,
    t.lan1 as lan1, t.lan2 as lan2, t.lan3 as lan3, t.diemgoctbkt, t.diemtbkt,  t.diemquatrinh,
    t.note as note
 from 
(SELECT "msv", sv1.ho, sv1.ho_dem, sv1.ten, sv1.ngay_sinh , "T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11",
    "T12", "T13", "T14", "T15", "T16",  COALESCE("T1",0) + COALESCE("T2",0)+ COALESCE("T3",0)+ COALESCE("T4",0)
    + COALESCE("T5",0)+ COALESCE("T6",0)+ COALESCE("T7",0)+ COALESCE("T8",0)+ COALESCE("T9",0)+ COALESCE("T10",0)
    + COALESCE("T11",0)+ COALESCE("T12",0)+ COALESCE("T13",0)+ COALESCE("T14",0)+ COALESCE("T15",0)
    + COALESCE("T16",0) as tonggiovang, sv1.diem_chuyen_can as diemchuyencan, sv1.diem_thuc_hanh as diemthuchanh,
    sv1.lan1 as lan1, sv1.lan2 as lan2, sv1.lan3 as lan3, sv1.diem_goc_tbkt as diemgoctbkt, sv1.diem_tbkt as diemtbkt,  sv1.diem_qua_trinh as diemquatrinh,
    sv1.note as note
    FROM crosstab(
      'select dd.ma_sinh_vien, l.tuan, sum(so_tiet_vang) as so_vang
    from t1.diem_danhs dd
    inner join t1.lich_trinh_giang_days l on l.id = dd.lich_trinh_giang_day_id
    where l.lop_mon_hoc_id = #{@lop_mon_hoc.id}
    and dd.so_tiet_vang > 0
    group by ma_sinh_vien, tuan
    order by 1,2',
    'select m from generate_series(1,16) m')
    AS ("msv" text, "T1" int, "T2" int, "T3" int, "T4" int, "T5" int, "T6" int, "T7" int, "T8" int, "T9" int, "T10" int
    , "T11" int, "T12" int, "T13" int, "T14" int, "T15" int, "T16" int)
    inner join t1.lop_mon_hoc_sinh_viens sv1 on sv1.ma_sinh_vien = msv and sv1.lop_mon_hoc_id = #{@lop_mon_hoc.id}

    union all
    select ma_sinh_vien as "msv", ho, ho_dem, ten, ngay_sinh, 0 as "T1", 0 as "T2", 
    0 as "T3", 0 as "T4", 0 as "T5", 0 as "T6", 
0 as "T7", 0 as "T8", 0 as "T9", 0 as "T10", 0 as "T11", 0 as "T12", 
0 as "T13", 0 as "T14", 0 as "T15", 0 as "T16", 0 as tongiovang , diem_chuyen_can , diem_thuc_hanh as diemthuchanh,
lan1, lan2, lan3, diem_goc_tbkt as diemgoctbkt, diem_tbkt as diemtbkt, diem_qua_trinh as diemquatrinh, note as note
from t1.lop_mon_hoc_sinh_viens where lop_mon_hoc_id=#{@lop_mon_hoc.id} and ma_sinh_vien not in (select dd.ma_sinh_vien
    from t1.diem_danhs dd
    inner join t1.lich_trinh_giang_days l on l.id = dd.lich_trinh_giang_day_id
    where l.lop_mon_hoc_id = #{@lop_mon_hoc.id}
    and dd.so_tiet_vang > 0)
 ) as t
 order by t.ten, t.ho_dem, t.ho, t.ngay_sinh