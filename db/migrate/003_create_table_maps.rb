class CreateTableMaps < ActiveRecord::Migration
  def self.up
    create_table :table_maps do |t|
          t.column "title", :text
          t.column "script_id", :integer
          t.column "line_number", :integer
          t.column "seq", :integer
          t.column "glyph", :text
          t.column "glyph_id", :text
          t.column "created_on", :date
          t.column "updated_on", :date
    end

    add_index "table_maps", ["glyph"], :name => "glyph_idx"
    add_index "table_maps", ["title"], :name => "title_idx"

  end

  def self.down
    drop_table :table_maps
  end
end

# create table table_maps (
#      id int default null auto_increment,
#      title varchar(255) default null,
#      script_id int default null,
#      line_number int default null,
#      seq int default null,
#      glyph varchar(255) default null,
#      glyph_id int default null,
#      created_on timestamp,
#      updated_on timestamp,
#      primary key (id),
#      key (title),
#      key (glyph)
# );