class User < ApplicationRecord

  has_secure_password
  validates :email, presence: true, uniqueness: true
  
# リフレッシュトークンのJWT IDを記憶
  def remember(jti)
    update!(refresh_jti: jti)
  end
# リフレッシュトークンのJWT IDを削除
  def forget
    update!(refresh_jti: nil)
  end
end
