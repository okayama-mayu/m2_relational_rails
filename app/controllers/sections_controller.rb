class SectionsController < ApplicationController
    def index 
        # binding.pry 
        if params[:search_exact] != nil 
            @sections = Section.search_exact(params[:search_exact])
        elsif params[:search_partial] != nil 
            @sections = Section.search_partial(params[:search_partial])
        elsif params[:num_sort] == "active"
            @sections = Section.sort_by_item_count
            @num_sort = "active"
        else 
            @sections = Section.all.order_by_time_created
        end
    end

    def show
        @section = Section.find(params[:id])
        @count = @section.total_items
    end

    def new 
        
    end

    def create
        @section = Section.create(section_params)
        redirect_to "/sections"
    end

    def edit
        @section = Section.find(params[:id])
    end

    def update 
        section = Section.find(params[:section_id])
        section.update(section_params)
        redirect_to "/sections/#{params[:section_id]}"
    end

    def destroy
        section = Section.find(params[:section_id])
        section.destroy
        redirect_to "/sections" 
    end

private 
    def section_params
        params.permit(:name, :vegan_options, :labor_intensity, :search)
    end
end