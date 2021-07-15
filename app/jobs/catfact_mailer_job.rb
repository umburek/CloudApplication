class CatfactMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      CatfactMailer.with(user: user).daily_catfact.deliver_now

    end
  end
end
