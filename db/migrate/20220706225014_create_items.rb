class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name 
      t.boolean :need_restock
      t.float :price 

      t.timestamps
    end
  end
end
