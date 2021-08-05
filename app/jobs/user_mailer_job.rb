class UserMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      SendCloudImage.call(user)
    end
  end
end
