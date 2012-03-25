class InstallAacms < ActiveRecord::Migration
  def self.up
    create_table :content do |t|
      t.integer  "page_id"
      t.text     "text"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "content_type_class"
      t.string   "key"
      t.string   "image"
      t.string   "file" 
    end

    add_index "content", ["page_id", "key"], :name => "index_content_on_page_id_and_key"

    create_table :recipes do |t|
      t.string   "title"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "type"
    end
  end

  def self.down
    drop_table :content
    drop_table :recipes
  end
end
