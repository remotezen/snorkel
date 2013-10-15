class AddColumnToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :to, :integer
  end
end
