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

ActiveRecord::Schema.define(:version => 20130610234830) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "can_bo_lops", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "dang_ky_day_bus", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "ngay_day_dang_ky"
    t.integer  "tiet_bat_dau"
    t.string   "phong"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "day_thays", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "ngay_day"
    t.string   "phong"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "diem_chi_tiets", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.integer  "diem"
    t.string   "loai_diem"
    t.integer  "lan"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "diem_chuyen_cans", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.integer  "tong_so_tiet"
    t.integer  "tong_so_tiet_vang"
    t.integer  "diem"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "diem_danhs", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "ngay_vang"
    t.integer  "so_tiet_vang"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "giang_viens", :force => true do |t|
    t.string   "ho_ten"
    t.string   "hoc_vi"
    t.string   "hoc_ham"
    t.string   "ma_don_vi"
    t.string   "ma_loai"
    t.string   "ma_giang_vien"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "kien_nghis", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.text     "noi_dung"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.integer  "nhom_id"
    t.boolean  "trang_thai"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "lich_trinh_giang_days", :force => true do |t|
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "ngay_day"
    t.text     "noi_dung_day"
    t.integer  "so_tiet_day"
    t.text     "nhan_xet_buoi_hoc"
    t.string   "phong"
    t.boolean  "xac_nhan_sv"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "lop_mon_hoc_sinh_viens", :force => true do |t|
    t.string   "ma_sinh_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "lop_mon_hocs", :force => true do |t|
    t.string   "ma_lop"
    t.string   "ma_giang_vien"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.integer  "so_tiet"
    t.integer  "so_tuan_hoc"
    t.datetime "ngay_bat_dau"
    t.datetime "ngay_ket_thuc"
    t.string   "phong_hoc"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "mon_hocs", :force => true do |t|
    t.string   "ma_mon_hoc"
    t.string   "ten_mon"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "nghi_days", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "ngay_day"
    t.string   "phong"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "nhat_kies", :force => true do |t|
    t.string   "ma_nguoi_dung"
    t.string   "ma_lop"
    t.text     "noi_dung"
    t.datetime "thoi_gian"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "ra_som_vao_muons", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "ngay_day"
    t.integer  "loai"
    t.string   "phong"
    t.integer  "tiet"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

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
  end

  create_table "tai_lieu_mon_hocs", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.text     "noi_dung"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "thong_bao_lop_hocs", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.text     "noi_dung"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.datetime "thoi_gian"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "tkb_giang_viens", :force => true do |t|
    t.string   "ma_giang_vien"
    t.string   "ma_lop"
    t.string   "ma_mon_hoc"
    t.string   "phong"
    t.string   "nam_hoc"
    t.integer  "hoc_ky"
    t.integer  "tuan_hoc_bat_dau"
    t.integer  "so_tuan"
    t.datetime "ngay_bat_dau"
    t.datetime "ngay_ket_thuc"
    t.integer  "so_tiet"
    t.integer  "tiet_bat_dau"
    t.integer  "thu"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "",      :null => false
    t.string   "encrypted_password",     :default => "",      :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role",                   :default => "guest", :null => false
    t.string   "code",                   :default => "",      :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["code"], :name => "index_users_on_code", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
