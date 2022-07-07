class Section < ApplicationRecord
    has_many :items 

    validates_presence_of :name, :vegan_options, :labor_intensity
end