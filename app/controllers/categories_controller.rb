class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
  end

  def new
    @category = Category.new
  end

  def destroy
  end
end
