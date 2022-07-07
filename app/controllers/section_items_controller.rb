class SectionItemsController < ApplicationController 
    def index 
        @section = Section.find(params[:section_id])
        @items = @section.items 
    end
end