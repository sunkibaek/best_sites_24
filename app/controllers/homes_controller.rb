class HomesController < ApplicationController
  def show
    @recent_sites = if params[:tag]
                      Site.with_tag(params[:tag])
                    else
                      Site
                    end

    @recent_sites = @recent_sites
      .order(id: :desc)
      .paginate(page: params[:page], per_page: 12)

    @popular_sites = Site.popular.limit(4)
  end
end
