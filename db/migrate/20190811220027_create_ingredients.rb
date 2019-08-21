class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :category
      t.string :subcategory
      t.string :variety
      t.timestamps
    end
  end
end
