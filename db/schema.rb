# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131108022235) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "diem_danhs", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.datetime "ngay_vang"
    t.integer  "so_tiet_vang"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.text     "note"
    t.boolean  "phep"
    t.string   "ma_giang_vien"
    t.integer  "lop_mon_hoc_id"
    t.integer  "lich_trinh_giang_day_id"
    t.datetime "destroyed_at"
  end

  add_index "diem_danhs", ["lich_trinh_giang_day_id"], :name => "index_diem_danhs_on_lich_trinh_giang_day_id"
  add_index "diem_danhs", ["lop_mon_hoc_id"], :name => "index_diem_danhs_on_lop_mon_hoc_id"

  create_table "giang_viens", :force => true do |t|
    t.string   "ho_ten"
    t.string   "hoc_vi"
    t.string   "hoc_ham"
    t.string   "ma_don_vi"
    t.string   "ma_loai"
    t.string   "ma_giang_vien"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "days"
    t.integer  "topics_count"
    t.integer  "posts_count"
    t.string   "ten_khoa"
  end

  add_index "giang_viens", ["ma_giang_vien"], :name => "index_giang_viens_on_ma_giang_vien"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lich_trinh_giang_days", :force => true do |t|
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.datetime "ngay_day"
    t.text     "noi_dung_day"
    t.integer  "so_tiet_day"
    t.string   "phong"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "so_vang"
    t.string   "ma_giang_vien"
    t.integer  "lop_mon_hoc_id"
    t.integer  "ratings"
    t.integer  "rating_score"
    t.text     "voters"
    t.integer  "loai"
    t.integer  "status"
    t.datetime "ngay_day_moi"
    t.string   "ma_giang_vien_moi"
    t.string   "phong_moi"
    t.string   "ma_mon_hoc_moi"
    t.string   "ten_mon_hoc_moi"
    t.integer  "so_tiet_day_moi"
    t.integer  "lop_mon_hoc_moi_id"
    t.integer  "tuan_moi"
    t.text     "note"
    t.integer  "tuan"
    t.integer  "siso"
    t.string   "tiet_nghi"
    t.integer  "user_id"
    t.datetime "destroyed_at"
    t.boolean  "nghile"
    t.integer  "creator_id"
  end

  add_index "lich_trinh_giang_days", ["lop_mon_hoc_id"], :name => "index_lich_trinh_giang_days_on_lop_mon_hoc_id"
  add_index "lich_trinh_giang_days", ["ma_giang_vien_moi"], :name => "index_lich_trinh_giang_days_on_ma_giang_vien_moi"

  create_table "lich_truc_nhats", :force => true do |t|
    t.datetime "ngay_truc"
    t.string   "phong"
    t.integer  "lop_mon_hoc_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "note"
    t.integer  "tuan"
    t.integer  "user_id"
  end

  add_index "lich_truc_nhats", ["lop_mon_hoc_id"], :name => "index_lich_truc_nhats_on_lop_mon_hoc_id"
  add_index "lich_truc_nhats", ["user_id"], :name => "index_lich_truc_nhats_on_user_id"

  create_table "lich_vi_phams", :force => true do |t|
    t.datetime "ngay_vi_pham"
    t.integer  "lop_mon_hoc_id"
    t.string   "phong"
    t.integer  "tuan"
    t.boolean  "lenmuon"
    t.boolean  "vesom"
    t.boolean  "bogio"
    t.text     "note1"
    t.text     "note2"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
    t.boolean  "status"
    t.integer  "nguoi_duyet_id"
  end

  add_index "lich_vi_phams", ["bogio"], :name => "index_lich_vi_phams_on_bogio"
  add_index "lich_vi_phams", ["lenmuon"], :name => "index_lich_vi_phams_on_lenmuon"
  add_index "lich_vi_phams", ["nguoi_duyet_id"], :name => "index_lich_vi_phams_on_nguoi_duyet_id"
  add_index "lich_vi_phams", ["user_id"], :name => "index_lich_vi_phams_on_user_id"
  add_index "lich_vi_phams", ["vesom"], :name => "index_lich_vi_phams_on_vesom"

  create_table "lop_gheps", :force => true do |t|
    t.string   "ma_lop_ghep"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "lop_mon_hoc_sinh_viens", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "ten_mon_hoc"
    t.string   "ma_lop_hanh_chinh"
    t.string   "loai"
    t.string   "ho_dem"
    t.string   "ten"
    t.integer  "group_id"
    t.integer  "so_tiet_vang"
    t.integer  "tong_so_tiet"
    t.integer  "so_vang_co_phep"
    t.string   "ma_lop_ghep"
    t.decimal  "lan1"
    t.decimal  "lan2"
    t.decimal  "lan3"
    t.decimal  "diem_thuc_hanh"
    t.integer  "diem_chuyen_can"
    t.boolean  "status"
    t.decimal  "lan4"
    t.decimal  "lan5"
    t.string   "ho"
    t.boolean  "tin_chi"
    t.boolean  "lop_ghep"
    t.integer  "lop_mon_hoc_id"
    t.integer  "diem_qua_trinh"
    t.string   "note"
    t.integer  "diem_tbkt"
    t.datetime "ngay_sinh"
    t.decimal  "diem_goc_tbkt"
    t.boolean  "lop_tin_chi"
    t.integer  "creator"
  end

  add_index "lop_mon_hoc_sinh_viens", ["group_id"], :name => "index_lop_mon_hoc_sinh_viens_on_group_id"
  add_index "lop_mon_hoc_sinh_viens", ["lop_mon_hoc_id"], :name => "index_lop_mon_hoc_sinh_viens_on_lop_mon_hoc_id"
  add_index "lop_mon_hoc_sinh_viens", ["ma_lop_ghep", "ma_mon_hoc"], :name => "index_lop_mon_hoc_sinh_viens_on_ma_lop_ghep_and_ma_mon_hoc"

  create_table "lop_mon_hocs", :force => true do |t|
    t.string   "ma_lop"
    t.string   "ma_giang_vien"
    t.string   "ma_mon_hoc"
    t.integer  "so_tiet"
    t.integer  "so_tuan_hoc"
    t.datetime "ngay_bat_dau"
    t.datetime "ngay_ket_thuc"
    t.string   "phong_hoc"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "ten_giang_vien"
    t.string   "ten_mon_hoc"
    t.text     "dssv"
    t.integer  "group"
    t.text     "group_diem"
    t.string   "ma_tro_giang"
    t.integer  "user_id"
    t.integer  "topics_count"
    t.integer  "posts_count"
    t.integer  "so_lan_kt"
    t.boolean  "thuc_hanh"
    t.text     "trucnhat"
    t.decimal  "so_tiet_phan_bo"
    t.datetime "destroyed_at"
    t.boolean  "bosung"
    t.decimal  "so_tiet_bo_sung"
    t.integer  "so_buoi_bo_sung"
    t.boolean  "da_duyet_bo_sung"
    t.integer  "siso"
    t.text     "tiet_thay_doi"
  end

  add_index "lop_mon_hocs", ["da_duyet_bo_sung"], :name => "index_lop_mon_hocs_on_da_duyet_bo_sung"
  add_index "lop_mon_hocs", ["ma_mon_hoc"], :name => "index_lop_mon_hocs_on_ma_mon_hoc"
  add_index "lop_mon_hocs", ["user_id"], :name => "index_lop_mon_hocs_on_user_id"

  create_table "mon_hocs", :force => true do |t|
    t.string   "ma_mon_hoc"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "ten_mon_hoc"
  end

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.integer  "lop_mon_hoc_id"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "ma_giang_vien"
  end

  add_index "posts", ["lop_mon_hoc_id", "topic_id"], :name => "index_posts_on_lop_mon_hoc_id_and_topic_id"

  create_table "sinh_viens", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ho_dem"
    t.string   "ten"
    t.date     "ngay_sinh"
    t.boolean  "gioi_tinh"
    t.string   "lop_hc"
    t.string   "ma_khoa_hoc"
    t.string   "ma_he_dao_tao"
    t.string   "ma_nganh"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "trang_thai"
    t.string   "ten_nganh"
    t.text     "ngay"
    t.integer  "topics_count"
    t.integer  "posts_count"
    t.boolean  "tin_chi"
    t.string   "ho"
    t.text     "trucnhat"
  end

  add_index "sinh_viens", ["lop_hc"], :name => "index_sinh_viens_on_lop_hc"
  add_index "sinh_viens", ["ma_sinh_vien"], :name => "index_sinh_viens_on_ma_sinh_vien"

  create_table "tenants", :force => true do |t|
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.string   "scheme"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "thong_bao_lop_hocs", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.text     "noi_dung"
    t.datetime "thoi_gian"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "lop_mon_hoc_id"
  end

  add_index "thong_bao_lop_hocs", ["lop_mon_hoc_id"], :name => "index_thong_bao_lop_hocs_on_lop_mon_hoc_id"

  create_table "tkb_giang_viens", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "phong"
    t.integer  "tuan_hoc_bat_dau"
    t.integer  "so_tuan"
    t.datetime "ngay_bat_dau"
    t.datetime "ngay_ket_thuc"
    t.integer  "so_tiet"
    t.integer  "tiet_bat_dau"
    t.integer  "thu"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "days"
    t.string   "ten_mon_hoc"
    t.string   "ten_giang_vien"
    t.string   "loai"
    t.integer  "lop_mon_hoc_id"
    t.datetime "destroyed_at"
  end

  add_index "tkb_giang_viens", ["lop_mon_hoc_id"], :name => "index_tkb_giang_viens_on_lop_mon_hoc_id"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.integer  "posts_count"
    t.integer  "lop_mon_hoc_id"
    t.integer  "user_id"
    t.boolean  "locked"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "ma_giang_vien"
  end

  add_index "topics", ["lop_mon_hoc_id"], :name => "index_topics_on_lop_mon_hoc_id"

  create_table "truc_nhats", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.integer  "lich_truc_nhat_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.boolean  "status"
  end

  add_index "truc_nhats", ["lich_truc_nhat_id"], :name => "index_truc_nhats_on_lich_truc_nhat_id"
  add_index "truc_nhats", ["ma_sinh_vien"], :name => "index_truc_nhats_on_ma_sinh_vien"
  add_index "truc_nhats", ["status"], :name => "index_truc_nhats_on_status"

  create_table "tuans", :force => true do |t|
    t.integer  "stt"
    t.datetime "tu_ngay"
    t.datetime "den_ngay"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "days"
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "code",                   :default => "", :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "role"
    t.string   "ho_dem"
    t.string   "ten"
  end

  add_index "users", ["code"], :name => "index_users_on_code", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_groups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
