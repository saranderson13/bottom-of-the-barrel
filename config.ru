require './config/env'

use Rack::MethodOverride
use SessionsController
use RecipeController
use UserController
use IngredientController

run ApplicationController
