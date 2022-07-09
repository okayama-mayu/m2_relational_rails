class Item < ApplicationRecord
    belongs_to :section 

    validates_presence_of :name, :price

    validates :need_restock, inclusion: [true, false]

    def self.needs_restock_only
        Item.where("need_restock = true")
    end
end