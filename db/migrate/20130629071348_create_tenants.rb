class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :nam_hoc
      t.integer :hoc_ky
      t.string :scheme

      t.timestamps
    end
  end
end
