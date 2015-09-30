class AddViewsCountToSites < ActiveRecord::Migration
  def change
    add_column :sites, :views_count, :integer, default: 0
  end
end
