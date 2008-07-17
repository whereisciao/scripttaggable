class CreateScripts < ActiveRecord::Migration
  def self.up
    create_table :scripts do |t|
          t.column "title", :text
          t.column "file_name", :text
          t.column "description", :text
          t.column "created_on", :date
          t.column "updated_on", :date
    end
  end

  def self.down
    drop_table :scripts
  end
end
