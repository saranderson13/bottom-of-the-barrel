class CreateRlikes < ActiveRecord::Migration[5.2]
  def change
    create_table :rlikes do |t|
      t.belongs_to :user
      t.belongs_to :recipe
    end
  end
end
