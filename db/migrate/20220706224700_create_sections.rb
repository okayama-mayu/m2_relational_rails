class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :name 
      t.boolean :vegan_options
      t.integer :labor_intensity

      t.timestamps
    end
  end
end
