class Recipe < ActiveRecord::Base

  validates :name, presence: { message: "You must enter a name for this recipe." }
  validates :name, uniqueness: { message: "A recipe by that name already exists." }
  validates :instructions, presence: { message: "You must select enter instructions." }
  validates :instructions, length: { maximum: 700, too_long: "%{count} characters is the maximum allowed" }

  belongs_to :creator, class_name: "User"
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :rlikes
  has_many :likers, through: :rlikes, source: :user

end
