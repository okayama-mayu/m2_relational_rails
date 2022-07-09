class SectionsController < ApplicationController
    def index 
        @sections = Section.all.order_by_time_created
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
        params.permit(:name, :vegan_options, :labor_intensity)
    end
end