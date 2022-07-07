class Item < ApplicationRecord
    belongs_to :section 

    validates_presence_of :name, :need_restock, :price
end