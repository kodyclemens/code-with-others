module CommentsHelper
  def username(user_id)
    user = User.find(user_id)
    user.username
  end

  def formatted_datetime(date_timestamp)
    date_timestamp.strftime("%A, %B %e, %Y at %l:%M %p")
  end
end