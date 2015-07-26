class SitesController < ApplicationController
  MSG_CREATE = 'Site has been successfully created.'

  before_action :require_login, only: [:new]

  def index
    @sites = Site.order(id: :desc).paginate(page: params[:page], per_page: 12)
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    @site.fetch_html_doc

    if @site.save
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

