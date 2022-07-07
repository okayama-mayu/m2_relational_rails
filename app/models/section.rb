class Section < ApplicationRecord
    has_many :items 
    
    validates_presence_of :name, :labor_intensity

    validates :vegan_options, inclusion: { in: [true, false] }
end