module CommentsHelper
  def username(user_id)
    user = User.find(user_id)
    user.username
  end

  def user_id(id)
    user = User.find(id)
    user.id
  end

  def formatted_datetime(date_timestamp)
    date_timestamp.strftime("%A, %B %e, %Y at %l:%M %p")
  end

  def user_avatar_url(user_id)
    user = User.find(user_id)
    user.avatar_url
  end
end
