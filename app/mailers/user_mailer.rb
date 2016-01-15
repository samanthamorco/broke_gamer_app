class UserMailer < ApplicationMailer

  def notify_user(user, game, deal)
    p ENV['USERNAME']
    p ENV['PASSWORD']
    p ENV['API_KEY']
    @user = user
    @game = game
    @deal = deal
    mail(from: "brokegamermod@gmail.com", to: @user.email, subject: 'A game on your wishlist is on sale')
  end
end
