class ItemsController < ApplicationController
    
    helper_method :sort_column, :sort_direction

    before_action :authenticate_user, except: [:index, :show]
    before_action :logged_in?, except: [:index, :show]
    before_action :current_user, except: [:index, :show]
    before_action :find_item, only: [:show, :edit, :update, :destroy]

    def index 
        if params[:search]
            @search = params[:search].singularize.downcase
            @items = Item.search(@search)
            
        else 
            @items = Item.order(sort_column + " " + sort_direction)
            #render "items/sort"
        end
    end
        
    def new 
        @item = Item.new 
    end
    
    def create 
        @item = current_user.items.build(item_params)
        if @item.save
            flash[:notice] = "Item successfully created!"
            redirect_to user_item_path(current_user, @item)
        else
            @errors = @item.errors.full_messages
            render :new
        end
    end

    def show      
    end

    def edit
        current_user_item(@item)
    end

    def update
        if @item.update(item_params)
            redirect_to user_item_path(current_user, @item), notice: "Item Updated!"
        else  
            render :edit
        end
    end

    def destroy 
        @item.destroy 
        redirect_to user_path(current_user), notice: "Deleted Item: #{@item.name}"
    end

    private 

    def item_params
        params.require(:item).permit(:name, :new, :description, :image, :price, :category_name)
    end

    def find_item
        @item = Item.find(params[:id])
    end  
    
    def sort_column
        #checks if column name is included or present, if not defaults to "name" column
        Item.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
        #checks to see if a direction param is selected or present, if not defaults to "asc"
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def current_user_item(item)
        if !current_user.items.include?(item)
            flash[:failure] = "Access Denied"
            render :show
        end
    end 
end