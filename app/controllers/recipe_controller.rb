class RecipeController < ApplicationController

  get '/recipes' do
    @recipes = Recipe.all
    erb :'recipes/all_recipes'
  end

  get '/recipes/new' do
    authenticate
    @ingredients = Ingredient.all
    @categories = @ingredients.isolate_categories
    erb :'/recipes/new'
  end

  post '/recipes' do
    authenticate
    @user = current_user
    @recipe = @user.recipes.build(name: params[:drink_name], instructions: params[:instructions])
    @recipe.save
    @ingredients = params.keys.map { |k| Ingredient.find(k.to_i) if k.to_i != 0 }.compact
    @ingredients.each { |i| RecipeIngredient.create(recipe_id: @recipe.id, ingredient_id: i.id) }
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    if object_exists?("Recipe", params[:id])
      @recipe = Recipe.find(params[:id])
      @ingredients = @recipe.ingredients
      @liked = rliked?(@recipe)
      @similar = similar_recipes(@recipe)
      # binding.pry
      erb :'recipes/show'
    else
      # That recipe does not exist.
      redirect '/home'
    end
  end

  post '/recipes/:id' do
    # binding.pry
    @recipe = Recipe.find(params[:id])
    # binding.pry
    if !rliked?(@recipe)
      @recipe.update(like_count: @recipe.like_count += 1)
      Rlike.create(recipe_id: @recipe.id, user_id: current_user.id)
    else
      @recipe.update(like_count: @recipe.like_count -= 1)
      Rlike.find_by(recipe_id: @recipe.id, user_id: current_user.id).destroy
    end
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id/edit' do
    if object_exists?("Recipe", params[:id])
      @recipe = Recipe.find(params[:id])
      authenticate_creator(@recipe)
      @ingredients = Ingredient.all
      @categories = @ingredients.isolate_categories
      @ingredient_ids = @recipe.ingredients.map { |i| i.id }
      erb :'recipes/edit'
    else
      # That recipe does not exist.
      redirect '/home'
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    authenticate_creator(@recipe)
    @recipe.update(name: params[:drink_name], instructions: params[:instructions])
    @recipe.ingredients.clear
    @ingredients = params.keys.map { |k| Ingredient.find(k.to_i) if k.to_i != 0 }.compact
    @ingredients.each { |i| RecipeIngredient.create(recipe_id: @recipe.id, ingredient_id: i.id) }
    # binding.pry
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    authenticate_creator(@recipe)
    @recipe.destroy
    redirect '/home'
  end
end
