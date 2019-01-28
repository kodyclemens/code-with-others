module LoginHelper

  def user_signup
    fill_in("user[username]", :with => "Daffy Duck")
    fill_in("user[email]", :with => "daffy@duck.com")
    fill_in("user[password]", :with => "quack")
    fill_in("user[password_confirmation]", :with => "quack")
    click_button('Register')
  end

end