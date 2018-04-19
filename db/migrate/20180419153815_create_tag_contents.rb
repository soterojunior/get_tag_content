class CreateTagContents < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_contents do |t|
      t.string :type_tag
      t.text :content
      t.references :index_content, index: true
      t.timestamps
    end
  end
end
