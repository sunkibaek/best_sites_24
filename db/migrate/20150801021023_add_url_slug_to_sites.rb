class AddUrlSlugToSites < ActiveRecord::Migration
  def change
    add_column :sites, :url_slug, :string
  end
end
