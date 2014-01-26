class MsiController < ApplicationController
  ActionController::Base.helpers.asset_path("nga_banner_top.gif", type: :image)
  def index
    @sites = $sites_path
    $stdout.puts @sites
  end
end
