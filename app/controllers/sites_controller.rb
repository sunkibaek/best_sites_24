class SitesController < ApplicationController
  MSG_CREATE = 'Site has been successfully created.'

  before_action :require_login, only: [:new, :create]

  def show
    if @site = (Site.find_by(url_slug: params[:id]) || Site.find(params[:id]))
      @site.views.create
    end
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)

    if @site.save && @site.fetch_html_doc && @site.generate_url_slug
      redirect_to @site, notice: MSG_CREATE
    else
      render 'new'
    end
  end

  private

  def site_params
    params.require(:site).permit(:url, :tags, :screenshot)
  end
end
