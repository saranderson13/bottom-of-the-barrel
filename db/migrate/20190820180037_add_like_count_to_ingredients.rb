class AddLikeCountToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :like_count, :integer, default: 0
  end
end
