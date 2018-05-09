require 'test_helper'

class VoteCommentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get vote_comment_create_url
    assert_response :success
  end

end
