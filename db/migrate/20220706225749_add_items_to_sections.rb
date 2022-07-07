class AddItemsToSections < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :section, foreign_key: true
  end
end
