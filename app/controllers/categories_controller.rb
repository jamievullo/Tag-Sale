class CategoriesController < ApplicationController

    helper_method :sort_column, :sort_direction
    
    def index 
        @categories = Category.order(sort_column + " " + sort_direction)
    end

    def new 
    end

    def create
        @category = Category.create(category_params)
    end

    def show 
        @category = Category.find(params[:id])
    end

    private 

    def category_params 
        params.require(:category).permit(:name)
    end

    def sort_column
        #checks if column name is included or present, if not defaults to "name" column
        Category.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
        #checks to see if a direction param is selected or present, if not defaults to "asc"
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
