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

    def self.search_exact(key_word)
        Item.where("LOWER(name) = ?", key_word.downcase)
    end

    def self.search_partial(key_word)
        item = Item.where("LOWER(name) LIKE ?", "%#{key_word.downcase}%")
    end
end