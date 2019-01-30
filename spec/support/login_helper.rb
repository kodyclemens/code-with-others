module LoginHelper

  def user_signup
    fill_in("user[username]", :with => "Daffy Duck")
    fill_in("user[email]", :with => "daffy@duck.com")
    fill_in("user[password]", :with => "quack")
    fill_in("user[password_confirmation]", :with => "quack")
    click_button('Register')
  end

  def user_login
    fill_in("username", :with => "Daffy Duck")
    fill_in("password", :with => "quack")
    click_button('Log In')
  end

  def create_user
    User.create(username: 'Daffy Duck', email: 'daffy@duck.com', password: 'quack')
  end

end