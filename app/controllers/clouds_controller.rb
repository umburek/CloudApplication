class CloudsController < ApplicationController
  before_action :authenticate_user!

  def new
    words_with_rotates = Quote.
      order(:score).
      limit(10).
      pluck(:label).
      map { |word| [word, rand(100)] }

    cloud = MagicCloud::Cloud.new(words_with_rotates, rotate: :square, scale: :linear)

    # To save to file, if not redering it for a page
    img = cloud.draw(800, 600) #default height/width
    img.write(Rails.root.join('app/assets/images/cloud.png'))

    @quotes = Quote.order(:score).limit(10)

  end
end