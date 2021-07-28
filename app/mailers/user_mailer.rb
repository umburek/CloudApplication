class UserMailer < ApplicationMailer
  def daily_cloud_image
    attachments.inline['cloud.png'] = File.read('app/assets/images/cloud.png')
    @user = params[:user]
    mail(to: @user.email, subject: "Cloud of Top10 quotes!")
  end
end