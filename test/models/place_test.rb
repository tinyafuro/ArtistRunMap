require 'test_helper'

#新しいPlaceの有効性に対するテスト
class PlaceTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # このコードは慣習的に正しくない
    @place = @user.place.build(name: "上水中学校", address: "東京都小平市上水南町1-7-1")
  end

  #正常な状態かどうかのテスト
  test "should be valid" do
    assert @place.valid?
  end
  #user_idが存在しているかどうかのテスト
  test "user id should be present" do
    @place.user_id = nil
    assert_not @place.valid?
  end

  #name属性の空文字テスト
  test "name should be present" do
    @place.name = "   "
    assert_not @place.valid?
  end
  #name属性の文字数上限テスト
  test "name should be at most 50 characters" do
    @place.name = "a" * 51
    assert_not @place.valid?
  end

  #address属性の空文字テスト
  test "address should be present" do
    @place.address = "   "
    assert_not @place.valid?
  end
  #address属性の文字数上限テスト
  test "address should be at most 140 characters" do
    @place.address = "a" * 141
    assert_not @place.valid?
  end

  #Place情報の順序（降順）テスト
  test "order should be most recent first" do
    assert_equal places(:most_recent), Place.first
  end

end
