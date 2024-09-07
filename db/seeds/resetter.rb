# frozen_string_literal: true

module Resetter
  def self.reset_db
    # To drop the DB completely, run this in the terminal:
    # rails db:drop || (psql -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'hotwire_testing_development' AND pid <> pg_backend_pid();" && rails db:drop)
    #
    tables_to_skip = %w[
      schema_migrations
      ar_internal_metadata
    ]
    ActiveRecord::Base.connection.tables.each do |table|
      next if tables_to_skip.include?(table)
      ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY CASCADE")
    end
  end
end
