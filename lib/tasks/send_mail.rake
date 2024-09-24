namespace :send_mail do
  # 本番環境でも使えるようにする
  desc "/controllers/mailers/user_mailer.rbのメール送信を実行する"
  task mail: :environment do
    UserMailer.new.daily_mail
  end

  desc "あああああああ"
  task daily: :environment do
    UsersController.new.mail
  end

end

