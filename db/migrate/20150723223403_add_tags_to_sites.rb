class AddTagsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :tags, :text, array: true, default: []
  end
end
