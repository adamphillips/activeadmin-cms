class Create<%= class_name.pluralize %> < ActiveRecord::Migration

  def self.up
    create_table :<%= plural_table_name.to_sym %> do |t|
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

    add_index :<%= plural_table_name.to_sym %>, 'slug'
    add_index :<%= plural_table_name.to_sym %>, 'url'
  end

  def self.down
    drop_table :<%= plural_table_name.to_sym %>
  end

end
