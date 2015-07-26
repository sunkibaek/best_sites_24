class AddAttachmentScreenshotToSites < ActiveRecord::Migration
  def self.up
    change_table :sites do |t|
      t.attachment :screenshot
    end
  end

  def self.down
    remove_attachment :sites, :screenshot
  end
end
