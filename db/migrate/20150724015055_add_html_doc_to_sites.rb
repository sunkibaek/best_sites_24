class AddHtmlDocToSites < ActiveRecord::Migration
  def change
    add_column :sites, :html_doc, :text
  end
end
