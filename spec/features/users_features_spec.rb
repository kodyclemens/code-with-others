require_relative "../rails_helper.rb"

describe 'Feature Test: User Interactions', :type => :feature do

  it 'successfully signs up a new user' do
    visit '/signup'
    expect(current_path).to eq('/signup')
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(current_path).to eq('/')
    expect(page).to have_content("Profile")
    expect(page).to have_content("Logout")
    visit '/users/1'
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Daffy Duck")
  end

  it "on sign up, successfully adds a session hash" do
    visit '/signup'
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'logs a user in' do
    create_user
    visit '/login'
    expect(current_path).to eq('/login')
    user_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'logs a user out' do
    create_user
    visit '/login'
    expect(current_path).to eq('/login')
    user_login
    expect(page).to have_content("Profile")
    expect(page).to have_content("Logout")
    click_link 'Logout'
    expect(page.get_rack_session).to_not include("user_id")
  end

  it 'user can create a team' do
    create_user
    visit '/login'
    user_login
    visit '/teams/new'
    make_team
    expect(page).to have_content("A New Team")
    expect(page).to have_content("Combine forces and conquer the world")
  end

  it 'cannot create a team while logged out' do
    visit '/teams/new'
    expect(page).to have_content('You must be logged in to access this section')
  end

end