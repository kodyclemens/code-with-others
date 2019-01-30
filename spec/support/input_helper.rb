module InputHelper
  def make_team
    fill_in("team[name]", :with => "A New Team")
    fill_in("team[avatar_url]", :with => "https://i.imgur.com/zXHbz7Z.jpg")
    fill_in("team[repo_url]", :with => "https://github.com/railsware")
    fill_in("team[description]", :with => "Combine forces and conquer the world")
    fill_in("team[goals]", :with => "Works as little as possible")
    fill_in("team[communication_method]", :with => "None yet...")
    click_button('Create Team')
  end

  def make_a_comment
    fill_in("comment[content]", :with => "You made a comment!")
    click_button('Create Comment')
  end

  def submit_user_technology_form
    fill_in("user_technology[technology_attributes][name]", :with => "Javascript")
    click_button('Add Technology')
  end

  def create_technology
    Technology.create(name: "Ruby")
  end
end