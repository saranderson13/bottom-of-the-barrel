class CreateIlikes < ActiveRecord::Migration[5.2]
  def change
    create_table :ilikes do |t|
      t.belongs_to :user
      t.belongs_to :ingredient
    end
  end
end
