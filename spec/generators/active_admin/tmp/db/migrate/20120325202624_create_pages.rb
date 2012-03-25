class CreatePages < ActiveRecord::Migration

  def self.up
    create_table :pages do |t|
      t.string   :title
      t.text     :description
      t.integer  :recipe_id
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :slug
      t.string   :url
      t.string   :meta_title
      t.string   :meta_keywords
      t.text     :meta_description
    end

    add_index :pages, 'slug'
    add_index :pages, 'url'
  end

  def self.down
    drop_table :pages
  end

end
