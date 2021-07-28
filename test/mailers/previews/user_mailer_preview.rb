# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def daily_cloud_image
    UserMailer.with(user: User.all.sample, fact: Cloud_imageServices::Cloud_image.new.daily_fact).daily_cloud_image
  end
end
