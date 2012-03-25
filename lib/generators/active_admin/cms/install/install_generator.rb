module ActiveAdmin
  module Cms
    class InstallGenerator < Rails::Generators::Base
      desc 'Installs the active admin cms'

      include Rails::Generators::Migration

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def self.source_root
        @_active_admin_cms_source_root ||= File.expand_path("../templates", __FILE__)
      end

      #def create_admin
        #template 'admin/pages.rb.erb', "app/admin/#{plural_table_name}.rb"
      #end

      #def create_model
        #template 'page.rb.erb', "app/models/#{file_path}.rb"
      #end

      #def create_migrations
        #Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do |filepath|
          #name = File.basename(filepath)
          #migration_template "migrations/#{name}", "db/migrate/#{name.gsub(/^\d+_/,'')}"
          #sleep 1
        #end
      #end

    end
  end
end

