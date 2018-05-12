class VoteController < ApplicationController
  def create
    data = vote_params # publication_id, user_id, comment_id
    result = Vote.where(user_id: data[:user_id],\
                        publication_id: data[:publication_id]).to_a
    publication = Publication.find(data['publication_id'])
    respond_to do |format|
      if result.empty?
        @vote = Vote.new(data)
        publication.votos += 1
        publication.forum.votos += 1
        publication.user.reputation += 1
        if @vote.save && publication.save && publication.user.save && publication.forum.save
          format.html do
            redirect_to publication, notice: 'UpVoted.'
          end
        else
          format.html do
            redirect_to publication, notice: 'Error ocurred'
          end
        end
      else
        format.html do
          redirect_to publication, notice: 'Already UpVoted this publication'
        end
      end
    end
  end

  def destroy
    vote = Vote.find(params[:vote][:vote_id])
    publication = vote.publication
    publication.votos -= 1
    publication.save
    vote.destroy
    redirect_to publication, notice: 'DownVoted'
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :publication_id)
  end
end
