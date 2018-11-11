require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', @user.name
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.place.count.to_s, response.body
    assert_select 'div.pagination'
    @user.place.paginate(page: 1).each do |place|
      assert_match place.name, response.body
      assert_match place.address, response.body
    end
  end
end
