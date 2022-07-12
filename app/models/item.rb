class Item < ApplicationRecord
    belongs_to :section 

    validates_presence_of :name, :price

    validates :need_restock, inclusion: [true, false]

    def self.needs_restock_only
        Item.where("need_restock = true")
    end

    def self.alpha_sort
        Item.order(:name)
    end

    def self.min_filter(min)
        Item.where("price >= #{min.to_i}")
    end

    def self.search(key_word)
        section = Item.where("LOWER(name) = ?", key_word.downcase)
    end
end