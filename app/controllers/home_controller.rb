class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @medias = InstagramApi.user.recent_media
  end
end
