class CreateRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :regions do |t|
      t.string :juhe_code
      t.string :freq
      t.string :region
      t.timestamps
    end
    add_index :regions, :juhe_code
  end
end
