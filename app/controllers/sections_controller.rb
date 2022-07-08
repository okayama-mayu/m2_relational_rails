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
        @section = Section.create(artist_params)
        redirect_to "/sections"
    end

    def artist_params
        params.permit(:name, :vegan_options, :labor_intensity)
    end
end