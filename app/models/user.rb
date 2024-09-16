class User < ApplicationRecord
  # token生成モジュール
  include TokenGenerateService
  #ログインフォームにパスワードを入れるために必要（パスワードのハッシュ化）
  has_secure_password
  # バリデーション
  validates :email, presence: true, uniqueness: true

  class << self
    # emailからアクティブなユーザーを返す
    def find_activated(email)
      find_by(email: email, activated: true)
    end
  end

  def email_activated?
    users = User.where.not(id: id)
    users.find_activated(email).present?
  end
# リフレッシュトークンのJWT IDを記憶
  def remember(jti)
    update!(refresh_jti: jti)
  end
# リフレッシュトークンのJWT IDを削除
  def forget
    update!(refresh_jti: nil)
  end
  #共通のjsonレスポンス 今回は登録アドレスとメール配信するかしないかのdeliverを指定
  def response_json(payload={})
    as_json(only:[:email,:deliver]).merge(payload).with_indifferent_access
  end

end
