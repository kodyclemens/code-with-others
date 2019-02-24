# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (team has_many comments) 
- [x] Include at least one belongs_to relationship (comment belongs_to team)
- [x] Include at least two has_many through relationships (user has_many teams through user_teams)
- [x] Include at least one many-to-many relationship (user has_many teams through user_teams, team has_many users through user_teams)
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (user has_many technologies through user_technologies, user_technologies skill_level column is a user submittable attribute)
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
- [x] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate

# Specifications for the JS Assessment

- [ ] Must have a Rails Backend and new requirements implemented through JavaScript.
- [x] Makes use of ES6 features as much as possible(e.g Arrow functions, Let & Const, Constructor Functions)
- [x] Must translate the JSON responses into Javascript Model Objects using either ES6 class or constructor syntax. 
- [x] Must render at least one index page (index resource - 'list of things') via JavaScript and an Active Model Serialization JSON Backend.
- [ ] Must render at least one show page (show resource - 'one specific thing') via JavaScript and an Active Model Serialization JSON Backend.
- [x] Your Rails application must reveal at least one `has-many` relationship through JSON that is then rendered to the page.
- [ ] Must use your Rails application to render a form for creating a resource that is submitted dynamically through JavaScript.
- [x] At least one of the JS Model Objects must have a method on the prototype.
