class User < ApplicationRecord

    before_save { self.email = email.downcase }
    
    #name属性のバリデーション
    validates :name, presence: true, length: { maximum:50 }

    #email属性のバリデーション
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum:255 }, format: {with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

    #パスワードハッシュ化管理メソッド
    has_secure_password
    #password属性のバリデーション
    validates :password, presence: true, length: { minimum: 6 }
end
