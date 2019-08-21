require './config/env'

users = [
  {name: "Sarah", username: "sanderson", password: "testing" },
  {name: "Sadie", username: "sadie_sadie", password: "sto0fski" },
  {name: "Sloan", username: "the_bitchy_one", password: "password" },
]

users.each do |u|
  User.create(u)
end

recipes = [
  {name: "Classic Bloody Mary", instructions: "Add 1oz vodka. Add a glob of horseradish and worcesterchire sauce. A few dashes of Tabasco. Add a few squirts of lemon juice, a dash of pepper and celery salt, and stir well. Fill glass with ice, and add Tomato Juice. Garnish with everything plus the kitchen sink. Sure celery. But get creative. Bacon, pickled okra - pickled anything really, olives, a mini-cheeseburger...etc." },
  {name: "Mimosa", instructions: "Add prosecco and your fave kind of juice at a 2:1 ratio to the size of glass corresponding to the size of your hangover." },
  {name: "The 'Responsible' Friend", instructions: "Add 1.5oz gin, a dash of bitters and a squirt of lime juice to a glass with ice. Top off with soda water." },
  {name: "VERY Dirty Martini", instructions: "Add 2oz Gin, 1oz Dry Vermouth, and the entire contents of an 8oz jar of olives to a shaker. Shake well, and serve." },
  {name: "The Juniper'o'Sarah", instructions: "Add 1oz gin and some lime juice to a glass. Fill with strawberry puree & enjoy!" },
  {name: "The Toronto", instructions: "It's like a manhattan but with Fernet-Branca instead of Vermouth and it's WAY better than it sounds (if you hate Fernet - if you like Fernet it's probably as good as it sounds). Add 2oz Bourbon, 1/2oz Fernet, 1/4oz simple syrup and a dash of bitters to a shaker. Shake well, and serve over a giant ice cube with an orange peel garnish." },
  {name: "Paloma", instructions: "mix all ingredients. swipe rim with lime wedge, and dip in salt. garnish with the same wedge." },
  {name: "Shirley Temple", instructions: "Pour the sprite over ice. Add a few drops of grenadine. NOT TOO MUCH. That shit is sweet." },
  {name: "FANCY Mimosa", instructions: "Like a normal mimosa but add Grand Marnier. & mix the juices so you can feel FANCY." },
  {name: "Irish Coffee", instructions: "Pour a shot of Baileys and a shot of whiskey into a coffee cup. Fill with coffee and top with whipped cream <3" },
  {name: "Tequila Sunrise", instructions: "Add tequila - add orange juice - I like to add a bit of soda water - float the grenadine." },
  {name: "Lemon Spritz", instructions: "Pour 1.5oz Vodka into a glass with ice. Add a fresh squeeze of lemon juice from a lemon wedge. Top off with soda water. Garnish with a curly lemon peel and a cherry. <3" }
]


recipes[0..3].each do |r|
  User.all[0].recipes.build(r).save
end
recipes[4..7].each do |r|
  User.all[1].recipes.build(r).save
end
recipes[8..11].each do |r|
  User.all[2].recipes.build(r).save
end


INGREDIENT_CATEGORIES.each do |cat, subcats|
  subcats.each do |subcat, ingredients|
    ingredients.each do |ingredient|
      Ingredient.create(category: cat, subcategory: subcat, variety: ingredient)
    end
  end
end



### DEPRECATED -- OLD INGREDIENT STRUCTURE
# ingredients = [
#   { name: "Hendrick's", category: "Spirit", subcategory: "Gin" },
#   { name: "Tito's", category: "Spirit", subcategory: "Vodka" },
#   { name: "Tomato Juice", category: "Mixer", subcategory: "Juice" },
#   { name: "Prosecco", category: "Wine", subcategory: "Sparkling" },
#   { name: "Soda Water", category: "Mixer", subcategory: "Carbonated" },
#   { name: "Lime Juice", category: "Accent", subcategory: "Juice" },
#   { name: "Angostura", category: "Accent", subcategory: "Bitters" },
#   { name: "Fernet-Branca", category: "Spirit", subcategory: "Digestive" },
#   { name: "Strawberry Puree", category: "Mixer", subcategory: "Puree" },
#   { name: "Lemon Juice", category: "Accent", subcategory: "Juice" },
#   { name: "Dolin", category: "Wine", subcategory: "Sweet Vermouth" },
#   { name: "Horseradish", category: "Additive", subcategory: "Flavor" },
#   { name: "Salt", category: "Garnish", subcategory: "Rim" },
#   { name: "Olives", category: "Garnish", subcategory: "Food" },
#   { name: "Olive Juice", category: "Accent", subcategory: "Juice" },
# ]
#
# ingredients[0..4].each do |i|
#   User.all[0].ingredients.build(i).save
# end
# ingredients[5..9].each do |i|
#   User.all[1].ingredients.build(i).save
# end
# ingredients[10..14].each do |i|
#   User.all[2].ingredients.build(i).save
# end
