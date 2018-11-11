require 'test_helper'

class PlacesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  #PlaceのUIに対する統合テスト
  test "place interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Place.count' do
      post places_path, params: { place: { name: "", address: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    place_name = "Place Name"
    place_address = "This place really ties the room together"
    assert_difference 'Place.count', 1 do
      post places_path, params: { place: { name: place_name, address: place_address } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match place_name, response.body
    assert_match place_address, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_place = @user.place.paginate(page: 1).first
    assert_difference 'Place.count', -1 do
      delete place_path(first_place)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

end
