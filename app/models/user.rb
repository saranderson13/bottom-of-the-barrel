class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: { message: "A name must be given." }
  validates :username, presence: { message: "A username must be given." }
  validates :username, uniqueness: { message: "That username has already been taken." }
  validates :password, length: { in: 6..20 }, unless: Proc.new { |a| a.password.blank? }

  has_many :recipes, foreign_key: "creator_id"
  has_many :rlikes
  has_many :recipe_likes, through: :rlikes, source: :recipe
  has_many :ilikes
  has_many :ingredient_likes, through: :ilikes, source: :ingredient
  # has_many :ingredients, foreign_key: "addedby_id"

end
