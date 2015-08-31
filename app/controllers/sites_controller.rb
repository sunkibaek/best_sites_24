class SitesController < ApplicationController
  MSG_CREATE = 'Site has been successfully created.'

  before_action :require_login, only: [:new, :create]

  def index
    @sites = if params[:tag]
               Site.with_tag(params[:tag])
             else
               Site
             end

    @sites = @sites.order(id: :desc).paginate(page: params[:page], per_page: 12)
  end

  def show
    @site = (Site.find_by(url_slug: params[:id]) || Site.find(params[:id]))
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
