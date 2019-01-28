require_relative "../rails_helper.rb"

describe 'Feature Test: User Signup', :type => :feature do

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

end