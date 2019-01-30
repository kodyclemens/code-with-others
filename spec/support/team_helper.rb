module TeamHelper
  def make_team
    fill_in("team[name]", :with => "A New Team")
    fill_in("team[avatar_url]", :with => "https://i.imgur.com/zXHbz7Z.jpg")
    fill_in("team[repo_url]", :with => "https://github.com/railsware")
    fill_in("team[description]", :with => "Combine forces and conquer the world")
    fill_in("team[goals]", :with => "Works as little as possible")
    fill_in("team[communication_method]", :with => "None yet...")
    click_button('Create Team')
  end
end