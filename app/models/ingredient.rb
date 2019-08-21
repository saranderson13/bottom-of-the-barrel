class Ingredient < ActiveRecord::Base

  ### DEPRECATED -- INGREDIENTS ARE NO LONGER CREATED BY USERS AND DO NOT NEED TO BE VALIDATED
  # validates :name, presence: { message: "You must enter a name for this ingredient." }
  # validates :name, uniqueness: { message: "An ingredient by that name already exists." }
  # validates :category, presence: { message: "You must select a category." }
  #
  ### DEPRECATED -- INGREDIENTS NO LONGER BELONG TO USERS
  # belongs_to :addedby, class_name: "User"
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :ilikes
  has_many :likers, through: :ilikes, source: :user

  def self.isolate_categories
    self.all.map { |i| i.category }.compact.uniq
  end

  def self.isolate_subcats(cat)
    self.all.map { |i| i.subcategory if i.category == cat }.compact.uniq
  end

  def self.list_all_in_spirit
    self.all.map { |i| [i.id, i.variety] if i.category == "Spirit" }.compact
  end

  def self.list_all_in_subcat(subcat)
    self.all.map { |i| [i.id, i.variety] if i.subcategory == subcat}.compact
  end

end
