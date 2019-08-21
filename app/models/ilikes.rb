class Ilike < ActiveRecord::Base

  belongs_to :ingredient
  belongs_to :user

end
