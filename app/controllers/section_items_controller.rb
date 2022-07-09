class SectionItemsController < ApplicationController 
    def index 
        @section = Section.find(params[:section_id])
        @items = @section.items 
    end

    def new 
        @section = Section.find(params[:section_id])
    end

    def create 
        section = Section.find(params[:section_id])
        item = Item.create(section_items_params)
        redirect_to "/sections/#{section.id}/items"
    end

private 
    def section_items_params
        params.permit(:name, :need_restock, :price, :section_id, :sort)
    end
end