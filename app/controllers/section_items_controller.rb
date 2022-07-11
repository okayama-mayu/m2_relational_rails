class SectionItemsController < ApplicationController 
    def index 
        @section = Section.find(params[:section_id])
        # binding.pry 
        if params[:sort] == "active" 
            @items = @section.items.alpha_sort 
            # binding.pry
        elsif params[:minimum] != nil 
            @items = @section.items.min_filter(params[:minimum])
        else 
            @items = @section.items 
        end
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
        params.permit(:name, :need_restock, :price, :section_id)
    end
end