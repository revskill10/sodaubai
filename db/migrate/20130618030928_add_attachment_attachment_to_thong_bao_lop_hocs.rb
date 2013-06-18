class AddAttachmentAttachmentToThongBaoLopHocs < ActiveRecord::Migration
  def self.up
    change_table :thong_bao_lop_hocs do |t|
      t.attachment :attachment
    end
  end

  def self.down
    drop_attached_file :thong_bao_lop_hocs, :attachment
  end
end
