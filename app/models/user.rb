class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 1 }, allow_nil: true
  validates :github_uid, uniqueness: true

  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :user_technologies
  has_many :technologies, through: :user_technologies
  has_many :comments

  def self.find_or_create_by_uid(auth)
    @user = find_by(github_uid: auth[:uid])

    if @user.nil?
      @user = User.create(github_uid: auth[:uid], username: auth[:info][:nickname],
                          email: auth[:info][:email], avatar_url: auth[:info][:image],
                          github_profile_url: auth[:info][:urls][:GitHub], password: SecureRandom.hex,
                          bio: auth[:extra][:raw_info][:bio], company: auth[:extra][:raw_info][:company])
    end
    @user
  end

  def link_github(github_uid)
    self.update(github_uid: github_uid)
    self.errors ? false : true
  end

  def admin?
    self.account_type == 'admin'
  end
end
