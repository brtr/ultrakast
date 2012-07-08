require 'rails/generators'

class ActsAsReadableMigrationGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :migration_name, :type => :string, :default => "acts_as_readable_migration"
  
  def generate_acts_as_readable_migration
    copy_file "migration.rb", "db/migrate/#{file_name}.rb"
  end
    
  private
  def file_name
    Time.now.strftime("%Y%m%d%H%M%S") + '_' + migration_name.underscore
  end
end
