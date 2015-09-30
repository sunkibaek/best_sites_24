class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
