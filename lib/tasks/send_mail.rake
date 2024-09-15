namespace :send_mail do
  # 本番環境でも使えるようにする
  desc "/controllers/mailers/user_mailer.rbのメール送信を実行する"
  task send: :environment do
    UsersController.new.send
  end

  task oreSaikyo: :environment do
    desc "asssssssss"
    puts "hello"
  end

end
