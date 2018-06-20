class DashboardController < ApplicationController
  def index
    if user_signed_in? && current_user.role.zero?
      @forums = Forum
      @publications = Publication
      @users = User
      @comments = Comment
      @subscriptions = Subscription
      @votes = Vote
      @vote_comments = VoteComment
      @moderators_a = 0
      Moderator.all.each do |m|
        if m.approved?
          @moderators_a += 1
        end
      end
      # @votes = Vote
      query = Publication.select(:user_id).group(:user_id).count
      selection = select_from query
      @avg_p = selection.inject(0.0) { |sum, el| sum + el[1] } / selection.size
      query = Comment.select(:user_id).group(:user_id).count
      selection = select_from query
      @avg_c = selection.inject(0.0) { |sum, el| sum + el[1] } / selection.size
      query = Vote.joins('INNER JOIN Vote_Comments ON votes.user_id =
        vote_comments.user_id').select(:user_id).group(:user_id).count
      selection = select_from query
      @avg_v = selection.inject(0.0) { |sum, el| sum + el[1] } / selection.size
      query = Subscription.select(:user_id).group(:user_id).count
      selection = select_from query
      @avg_s = selection.inject(0.0) { |sum, el| sum + el[1] } / selection.size
    else
      redirect_to :home
    end
  end

  def select_from(hash)
    top = hash.sort_by { |_key, value| value }
    top
  end
end
