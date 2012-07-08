require 'acts-as-readable/acts_as_readable'
require 'acts-as-readable/reading'
require 'acts-as-readable/user_with_readings'
#require File.expand_path('../generators/acts_as_readable_migration/acts_as_readable_migration_generator', __FILE__)

ActiveRecord::Base.send :include, ActiveRecord::Acts::Readable
