SESSION_SECRET = ENV['SINATRA_ENV']

INGREDIENT_CATEGORIES = {
  "Base" => {
    "Spirit" => [
      "Gin",
      "Vodka",
      "Rum",
      "Whiskey",
      "Whisky",
      "Bourbon",
      "Tequila",
      "Mezcal",
      "Moonshine",
      "Brandy",
      "Cognac",
      "Pisco",
      "Scotch",
      "Soju",
      "Absinthe",
      "Schnapps",
      "Ouzo"
    ],
    "Wine" => [
      "Dry Vermouth",
      "Port",
      "Prosecco",
      "Rosé",
      "Sparkling Rosé",
      "Red Wine",
      "Sparkling Red Wine",
      "Sweet Vermouth",
      "White Wine"
    ]
  },
  "Mixer" => {
    "Juice" => [
       "Orange Juice",
       "Pineapple Juice",
       "Apple Juice",
       "Cranberry Juice",
       "Cran-raspberry Juice",
       "Grapefruit Juice",
       "Grape Juice",
       "Tomato Juice",
       "Lemon Juice",
       "Lime Juice"
     ],
     "Carbonated" => [
       "Soda Water",
       "Tonic",
       "Coke",
       "Sprite",
       "Ginger Ale",
       "Ginger Beer",
       "Diet Coke",
     ],
    "Bitters" => [
      "Peychaud's",
      "Angostura"
    ],
    "Purees" => [
      "Strawberry Puree",
      "Pineapple Puree",
      "Coconut Puree"
    ],
    "Other" => [
      "Simple Syrup",
      "Grenadine",
      "Coffee",
      "Tea",
      "Cream",
      "Tabasco Sauce",
      "Worcesterchire Sauce",
      "Horseradish"
    ]
  },
  "Liqueurs" => {
    "Berry / Fruit" => [
      "99 Berries",
      "Chambord",
      "Cointreau",
      "Curaçao",
      "Grand Marnier",
      "Limoncello",
      "Midori",
      "Pama",
      "Pucker",
      "Triple Sec"
    ],
    "Coffee" => [
      "Kahlúa",
      "St. George Spirits",
      "Tia Maria"
    ],
    "Cream" => [
      "Baileys Irish Cream",
      "Dooley's"
    ],
    "Crème" => [
      "Crème de cacao",
      "Crème de menthe"
    ],
    "Flower" => [
      "Rosolio",
      "St. Germain"
    ],
    "Herbal" => [
      "Anís",
      "Amaretto",
      "Amaro",
      "Bénédictine",
      "Campari",
      "Chartreuse",
      "Everglo",
      "Fernet",
      "Goldschlager",
      "Jagermeister",
      "Rumpleminze",
      "Sambuca",
      "Tuaca",
      "Underberg"
    ],
    "Honey" => [
      "Drambuie",
      "Other"
    ],
    "Nut-Flavored" => [
      "Amaretto",
      "Disaronno",
      "Frangelico"
    ]
  },
  "Garnish" => {
    "Fruit" => [
      "Orange Peel",
      "Orange Wedge",
      "Lemon Peel",
      "Lemon Wedge",
      "Lime Peel",
      "Lime Wedge",
      "Cherry",
      "Olives",
      "Cocktail Onion",
      "Raspberries"
    ],
    "Special" => [
      "Bacon",
      "Pickle",
      "Pickled Okra",
      "Celery",
      "Mint Leaves"
    ],
    "Rim" => [
      "Salt Rim",
      "Spicy Salt Rim",
      "Sugar Rim",
      "Dipped Chocolate Rim"
    ],
    "Toppings" => [
      "Whipped Cream"
    ]
  }
}
