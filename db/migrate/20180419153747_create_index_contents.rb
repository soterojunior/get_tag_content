class CreateIndexContents < ActiveRecord::Migration[5.1]
  def change
    create_table :index_contents do |t|
      t.text :url_page
      t.timestamps
    end
  end
end
