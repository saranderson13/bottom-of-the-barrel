class AddLikeCountToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :like_count, :integer, default: 0
  end
end
