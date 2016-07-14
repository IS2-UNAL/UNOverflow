require 'test_helper'

class LikesCommentsByUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @likes_comments_by_user = likes_comments_by_users(:one)
  end

  test "should get index" do
    get likes_comments_by_users_url
    assert_response :success
  end

  test "should get new" do
    get new_likes_comments_by_user_url
    assert_response :success
  end

  test "should create likes_comments_by_user" do
    assert_difference('LikesCommentsByUser.count') do
      post likes_comments_by_users_url, params: { likes_comments_by_user: { comment_id: @likes_comments_by_user.comment_id, is_possitive: @likes_comments_by_user.is_possitive, user_id: @likes_comments_by_user.user_id } }
    end

    assert_redirected_to likes_comments_by_user_url(LikesCommentsByUser.last)
  end

  test "should show likes_comments_by_user" do
    get likes_comments_by_user_url(@likes_comments_by_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_likes_comments_by_user_url(@likes_comments_by_user)
    assert_response :success
  end

  test "should update likes_comments_by_user" do
    patch likes_comments_by_user_url(@likes_comments_by_user), params: { likes_comments_by_user: { comment_id: @likes_comments_by_user.comment_id, is_possitive: @likes_comments_by_user.is_possitive, user_id: @likes_comments_by_user.user_id } }
    assert_redirected_to likes_comments_by_user_url(@likes_comments_by_user)
  end

  test "should destroy likes_comments_by_user" do
    assert_difference('LikesCommentsByUser.count', -1) do
      delete likes_comments_by_user_url(@likes_comments_by_user)
    end

    assert_redirected_to likes_comments_by_users_url
  end
end
