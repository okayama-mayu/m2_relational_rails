class Section < ApplicationRecord
    has_many :items 
    
    validates_presence_of :name, :labor_intensity

    validates :vegan_options, inclusion: [true, false]

    def order_by_time_created
        binding.pry 
    end
end