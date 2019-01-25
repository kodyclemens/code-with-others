module TeamsHelper
  def creator_name(creator_id)
    user = User.find(creator_id)
    user.username
  end
end
