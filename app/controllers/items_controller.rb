class ItemsController < ApplicationController
    def index 
        if params[:search_exact] != nil 
            @items = Item.search_exact(params[:search_exact])
        elsif params[:search_partial] != nil 
            @items = Item.search_partial(params[:search_partial])
        else 
            @items = Item.needs_restock_only 
        end
    end

    def show
        @item = Item.find(params[:id])
    end

    def edit 
        @item = Item.find(params[:item_id])
    end

    def update
        item = Item.find(params[:item_id])
        item.update(item_params)
        redirect_to "/items/#{item.id}"
    end

    def destroy 
        item = Item.find(params[:item_id])
        item.destroy
        redirect_to "/items"
    end

private
    def item_params
        params.permit(:name, :need_restock, :price)
    end

end