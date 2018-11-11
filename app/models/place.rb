class Place < ApplicationRecord

  #User／Placeの関連付け（１対１）
  belongs_to :user

  #デフォルトの順序を指定
  default_scope -> { order(created_at: :desc) }

  #画像アップローダー
  mount_uploader :picture, PictureUploader
  validate :picture_size

  #バリデーション
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 140 }
  
  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
