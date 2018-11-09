

#セッションはないがクッキーだけが残っている状態でブラウザを開いた際のテスト（永続的セッションのテスト）
require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    #sessionは作らずrememberでクッキーだけ作成した状態を再現
    remember(@user)
  end

  #クッキーが残っているので前回のユーザーと現在のユーザーが一致するテスト
  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

    #記憶ダイジェストが記憶トークンと正しく対応していない場合
  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end