#
# application_controller.rbでincludeされているので
# どのControllerからでも呼べるメソッド
#
module SessionsHelper

	# 渡されたユーザーでログインする
  	def log_in(user)
    	session[:user_id] = user.id
	end

	# ユーザーのセッションを永続的にする
	def remember(user)
		#Userモデルのrememberメソッドを呼び出してランダムに生成されたトークンをUserモデルへ保存
		user.remember
		#ユーザーIDと記憶トークンの永続cookiesを作成
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# 渡されたユーザーがログイン済みユーザーであればtrueを返す
	def current_user?(user)
		user == current_user
	end

	# # 現在ログイン中のユーザーを返す (いる場合)
	# def current_user
	# 	if session[:user_id]
	# 		@current_user ||= User.find_by(id: session[:user_id])
	# 	end
	# end

	# 記憶トークン（cookie）に対応するユーザーを返す
	def current_user
		#セッションがある場合
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		#セッションはないがクッキーが残っている場合
		elsif (user_id = cookies.signed[:user_id])
			# raise	# テストがパスすれば、この部分がテストされていないことがわかる	
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
			log_in user
			@current_user = user
			end
		end
	end
	

	# ユーザーがログインしていればtrue、その他ならfalseを返す
	def logged_in?
		!current_user.nil?
	end

	# 永続的セッションを破棄する
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# 現在のユーザーをログアウトする
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# 記憶したURL (もしくはデフォルト値) にリダイレクト
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	# アクセスしようとしたURLを覚えておく
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end

	# Placeの削除ボタンで元のURLへ戻る
	def redirect_before_url(default = root_path)
		return session[:before_forwarding_url] || default
		session.delete(:before_forwarding_url)
	end

	# 次の画面へアクセスする前に現在のURLを覚えておく
	def before_location(current_url)
		session[:before_forwarding_url] = current_url
	end
	
end
