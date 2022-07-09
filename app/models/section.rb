class Section < ApplicationRecord
    has_many :items, :dependent => :destroy
    
    validates_presence_of :name, :labor_intensity

    validates :vegan_options, inclusion: [true, false]

    def self.order_by_time_created
        order(created_at: :desc)
    end

    def total_items
        items.count 
    end
end