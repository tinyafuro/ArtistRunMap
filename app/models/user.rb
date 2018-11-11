class User < ApplicationRecord

    #User／Placeの関連付け（１対多）
    has_many :place, dependent: :destroy
    
    #トークンのローカル変数
    attr_accessor :remember_token

    before_save { self.email = email.downcase }
    
    #name属性のバリデーション
    validates :name, presence: true, length: { maximum:50 }

    #email属性のバリデーション
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum:255 }, format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

    #パスワードハッシュ化管理メソッド
    has_secure_password
    #password属性のバリデーション
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # 試作feedの定義
    def feed
        Place.where("user_id = ?", id)
    end

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # ユーザーのログイン情報を破棄する
    def forget
        update_attribute(:remember_digest, nil)
    end
    
end
