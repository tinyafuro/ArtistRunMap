require 'test_helper'

class PlacesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @place = places(:orange)
  end

  #ログインしていない状態でのPlace登録ができないテスト
  test "should redirect create when not logged in" do
    assert_no_difference 'Place.count' do
      post places_path, params: { place: { name: "Lorem ipsum", address: "LoremIpsumHouse" } }
    end
    assert_redirected_to login_url
  end

  #ログインしていない状態でのPlace削除ができないテスト
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Place.count' do
      delete place_path(@place)
    end
    assert_redirected_to login_url
  end

  #間違ったユーザーによるPlace削除に対してテスト
  test "should redirect destroy for wrong place" do
    log_in_as(users(:michael))
    place = places(:ants)
    assert_no_difference 'Place.count' do
      delete place_path(place)
    end
    assert_redirected_to root_url
  end

end
