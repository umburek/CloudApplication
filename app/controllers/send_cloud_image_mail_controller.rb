class SendCloudImageMailController < ApplicationController
  before_action :authenticate_user!

  def create
    SendCloudImage.call(current_user)

    redirect_back(fallback_location: root_path, flash: { success: 'Mail successfuly sent' })
  end
end