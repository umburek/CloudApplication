class UserMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      user_quotes = Quote.all.where(user_id: user.id)
      if user_quotes.count > 2
        words = user_quotes.
          order(:score).
          limit(2).
          pluck(:label).
          map { |word| [word, rand(45)] }
        @quotes = user_quotes.
          order(:score).
          limit(2)
        cloud = MagicCloud::Cloud.new(words, rotate: :free, scale: :sqrt)
        img = cloud.draw(960, 600)
        img.write('app/assets/images/cloud.png')
        if File.exists?('app/assets/images/cloud.png')
          UserMailer.daily_cloud_image.deliver_now
        end
      end
    end
  end

  # CatfactMailer.with(user: user).daily_catfact.deliver_now

end
