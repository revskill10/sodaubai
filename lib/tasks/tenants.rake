namespace :tenants do
  namespace :db do
    desc "runs db:migrate on each tenant's private schema"
    task migrate: :environment do
      verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migration.verbose = verbose

      Tenant.all.each do |tenant|
        puts "migrating tenant #{tenant.id} (#{tenant.scheme})"
        PgTools.set_search_path tenant.scheme, false
        version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
        ActiveRecord::Migrator.migrate("db/migrate/", version)
      end
    end
    
  end
end
