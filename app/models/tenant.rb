class Tenant < ActiveRecord::Base
  attr_accessible :hoc_ky, :nam_hoc, :scheme

  after_create :prepare_tenant
  SHARED_TABLES = [:tenants, :users, :active_admin_comments, :schema_migrations]
  private

  def prepare_tenant
    create_schema
    load_tables
  end

  def create_schema
    PgTools.create_schema scheme unless PgTools.schemas.include? scheme
  end

  def load_tables
    return if Rails.env.test?
    PgTools.set_search_path scheme, false
    load "#{Rails.root}/db/schema.rb"
    Tenant::SHARED_TABLES.each {|name| connection.execute %{drop table "#{name}" } }
    PgTools.restore_default_search_path
  end
end
