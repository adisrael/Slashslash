module PublicationsHelper
  def check_credentials(user, publication)
    if user.role.zero?
      return true
    elsif user.moderated_forums.include?(publication.forum)
      return true
    end
    false
  end
end
