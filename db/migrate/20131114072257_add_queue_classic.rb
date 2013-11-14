class AddQueueClassic < ActiveRecord::Migration	
  def up
  	return if PgTools.private_search_path?
    QC::Setup.create
  end

  def down
  	return if PgTools.private_search_path?
    QC::Setup.drop
  end
end
