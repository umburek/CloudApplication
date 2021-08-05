class SendCloudImage < Patterns::Service
  MINIMUM_USER_QUOTES = 2

  def initialize(user)
    @user = user
  end

  def call
    if user_quotes.count > MINIMUM_USER_QUOTES
      create_cloud_image &&
        send_email
    end
  end

  private

  attr_reader :user

  def create_cloud_image
    cloud_image.write('app/assets/images/cloud.png')
  end

  def send_email
    UserMailer.with(user: user).daily_cloud_image.deliver_now
  end

  def user_words
    user_quotes.
      order(:score).
      limit(10).
      pluck(:label).
      map { |word| [word, rand(45)] }
  end

  def cloud_image
   MagicCloud::Cloud.new(user_words, rotate: :free, scale: :sqrt).draw(960, 600)
  end

  # Memoization
  def user_quotes
    @user_quotes ||= user.quotes
  end
end