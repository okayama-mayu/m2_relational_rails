class Section < ApplicationRecord
    has_many :items, :dependent => :destroy
    
    validates_presence_of :name, :labor_intensity

    validates :vegan_options, inclusion: [true, false]

    def self.order_by_time_created
        Section.order(created_at: :desc)
    end

    def total_items
        items.count 
    end

    def self.sort_by_item_count
        # SELECT * 
        # FROM sections 
        # INNER JOIN items 
        #     ON sections.id = items.section_id 
        # GROUP BY 
        #     sections.id 
        # ORDER BY 
        #     COUNT(section.items) DESC 

        # Active Record help: https://stackoverflow.com/questions/40111685/order-by-count-of-a-models-association-with-a-particular-attribute

        # Arel.sql help: https://stackoverflow.com/questions/59275090/order-by-count-in-rails-6

        Section.joins(:items)
        .group('sections.id') 
        .order(Arel.sql('count(sections.id) DESC'))
    end

    def self.search(key_word)
            section = Section.where("LOWER(name) = ?", key_word.downcase) 
    end
end