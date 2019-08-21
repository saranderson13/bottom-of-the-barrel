class ApplicationController < Sinatra::Base

  require './config/env'

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'

    enable :sessions
    set :session_secret, SESSION_SECRET
  end

  get '/' do
    redirect '/home'
  end

  get '/home' do
    @recipes = Recipe.all
    @users = User.all
    @popular = Recipe.order(like_count: :desc).limit(3)
    @new = Recipe.order(created_at: :desc).limit(3)
    @suggestions = logged_in? && suggestions?(current_user) ? you_may_like(current_user) : nil
    erb :home
  end

  get '/search' do
    @ingredients = Ingredient.all
    @categories = @ingredients.isolate_categories
    erb :search
  end

  post '/found' do
    @matches = find_matches
    erb :found
  end


  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end

    def authenticate
      redirect '/login' if !logged_in?
    end

    def authenticate_creator(recipe)
      authenticate
      redirect '/home' if recipe && (current_user != recipe.creator)
    end

    def authenticated_user?(user)
      user && (user == current_user) ? true : false
    end

    def object_exists?(klass, id)
      klass.constantize.exists?(id)
    end

    def parse_password_error(user)
      user.errors.full_messages.map do |msg|
        "#{msg}." if msg.match(/Password/)
      end.compact
    end

    def parse_textarea(instructions)
      instructions.gsub("\r\n", "<br>")
    end

    def current_ingredients(recipe)
      recipe.ingredients.map { |i| i.id }
    end

    def rliked?(recipe)
        logged_in? && Rlike.find_by(recipe_id: recipe.id, user_id: current_user.id) ? true : false
    end

    def iliked?(ingredient)
        logged_in? &&Ilike.find_by(ingredient_id: ingredient.id, user_id: current_user.id) ? true :false
    end

    def used_in_sample(ingredient)
      if ingredient.recipes.count > 0
        if ingredient.recipes.count < 5
          ingredient.recipes
        else
          ingredient.recipes.sample(5)
        end
      else
        nil
      end
    end

    def suggestions?(user)
      (user.ilikes.count + user.rlikes.count) > 3
    end

    def you_may_like(user)
      all_likes = []
      selected_likes = []
      working_ingredients = []
      suggestions = []
      already_liked = user.rlikes.map { |rl| Recipe.find(rl.recipe_id)}

      # Collect all likes
      user.ilikes.each { |i| all_likes << i }
      user.rlikes.each { |r| all_likes << r }

      # Randomly select 3 likes to use as a base
      until selected_likes.length == 3 do
        s = all_likes.sample
        selected_likes << s unless selected_likes.include?(s)
      end

      # Extract ingredients from selected likes.
      # Add ingredient if the like is already an ingredient.
      # Add ingredients if like is a recipe (but not garnish ingredients)
      selected_likes.each do |like|
        if like.class == "Rlike".constantize
          extract = Recipe.find(like.recipe_id).ingredients
          extract.each { |i| working_ingredients << i if i.category != "Garnish" }
        else
          working_ingredients << Ingredient.find(like.ingredient_id)
        end
      end

      # From working_ingredients, collect all recipes that use each ingredient.
      # Make sure the suggestion array is unique.
      working_ingredients.each do |i|
        i.recipes.each { |r| suggestions << r if !already_liked.include?(r) && r.creator != current_user }
        suggestions.uniq!
      end

      # If more than three suggestions were generated, randomly select three to feature.
      # Otherwise return all suggestions.
      if suggestions.length > 3
        suggestions.sample(3)
      else
        suggestions
      end
    end

    def similar_recipes(recipe)
      recipe_mains = recipe.ingredients.map { |i| i unless i.category == "Garnish" }.compact
      similar = []
      recipe_mains.each do |i|
        if i.category != "Garnish"
          i.recipes.each do |r|
            compare_mains = r.ingredients.map { |i| i unless i.category == "Garnish" }.compact
            similar << r if (recipe_mains - (recipe_mains - compare_mains)).length >= 2 && r != recipe
          end
        end
      end
      similar.uniq!
    end

    def find_matches
      selected = params.keys.map { |id| Ingredient.find(id.to_i) }
      recipes = Recipe.all
      matches = []
      partial_matches = []

      recipes.each do |r|
        if r.ingredients.any? { |i| selected.include?(i) }
          if r.ingredients - (r.ingredients - selected) == selected
            matches << r
          else
            partial_matches << r
          end
        end
      end
      results = {
        matches: matches,
        part_matches: partial_matches
      }
    end

  end
end
