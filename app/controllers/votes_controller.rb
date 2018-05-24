class VotesController < ApplicationController
  def create
    data = vote_params # publication_id, user_id, positive
    result = Vote.where(user_id: data[:user_id],
                        publication_id: data[:publication_id],
                        positive: data[:positive]).to_a
    respond_to do |format|
      if result.empty?
        @vote = Vote.new(data)
        if @vote.save
          format.html do
            publication = balance
            redirect_to publication, notice: 'Voted.'
          end
          balance
        else
          format.html do
            redirect_to publication, notice: 'Error ocurred'
          end
        end
      else
        format.html do
          redirect_to result[0].publication, notice: 'Max Votes Reached'
        end
      end
    end
  end

  private

  def balance
    publication = @vote.publication
    inverse = Vote.where(user_id: @vote.user_id,
                         publication_id: @vote.publication_id,
                         positive: !@vote.positive).to_a
    unless inverse.empty?
      inverse[0].destroy
      @vote.destroy
    end
    publication
  end

  def vote_params
    params.require(:vote).permit(:user_id, :publication_id, :positive)
  end
end
