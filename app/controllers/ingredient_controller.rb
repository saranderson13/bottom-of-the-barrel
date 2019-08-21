class IngredientController < ApplicationController

  get '/ingredients' do
    @ingredients = Ingredient.all
    @categories = @ingredients.isolate_categories
    erb :'ingredients/all_ingredients'
  end

  # get '/ingredients/new' do
  #   authenticate
  #   erb :'ingredients/new'
  # end
  #
  # post '/ingredients/:id' do
  #   authenticate
  #   @user = current_user
  #   @ingredient = @user.ingredients.build(name: params[:name], category: params[:category], subcategory: params[:subcategory] )
  #   @ingredient.save
  #   redirect "/ingredients/#{ @ingredient.id }"
  # end

  get '/ingredients/:id' do
    if object_exists?("Ingredient", params[:id])
      @ingredient = Ingredient.find(params[:id])
      @liked = iliked?(@ingredient)
      @used_in = used_in_sample(@ingredient)
      # binding.pry
      erb :'ingredients/show'
    else
      # The ingredient does not exist.
      redirect '/home'
    end
  end

  post '/ingredients/:id' do
    @ingredient = Ingredient.find(params[:id])
    if !iliked?(@ingredient)
      @ingredient.update(like_count: @ingredient.like_count += 1)
      Ilike.create(ingredient_id: @ingredient.id, user_id: current_user.id)
    else
      @ingredient.update(like_count: @ingredient.like_count += 1)
      Ilike.find_by(ingredient_id: @ingredient.id, user_id: current_user.id).destroy
    end
    redirect "/ingredients/#{@ingredient.id}"
  end

  get '/ingredients/:id/recipes' do
    @ingredient = Ingredient.find(params[:id])
    @recipes = @ingredient.recipes
    erb :'ingredients/recipes'
  end



  # get '/ingredients/:id/edit' do
  #   if object_exists?("Ingredient", params[:id])
  #     @ingredient = Ingredient.find(params[:id])
  #     authenticate_creator(@ingredient)
  #     @categories = INGREDIENT_CATEGORIES
  #     @subcategories = INGREDIENT_SUBCATEGORIES
  #     erb :'ingredients/edit'
  #   else
  #     # The ingredient does not exist.
  #     redirect '/home'
  #   end
  # end
  #
  # put '/ingredients/:id' do
  #   @ingredient = Ingredient.find(params[:id])
  #   authenticate_creator(@ingredient)
  #   @ingredient.update(name: params[:name], category: params[:category], subcategory: params[:subcategory])
  #   redirect "/ingredients/#{@ingredient.id}"
  # end
  #
  # delete '/ingredients/:id' do
  #   @ingredient = Ingredient.find(params[:id])
  #   authenticate_creator(@ingredient)
  #   @ingredient.destroy
  #   redirect '/home'
  # end

end
