class SectionsController < ApplicationController
    def index 
        @sections = Section.all.order_by_time_created
    end

    def show
        @section = Section.find(params[:id])
    end
end