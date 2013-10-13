class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.integer :user_id
      t.boolean :login_status, default: false

      t.timestamps
    end
    add_index :logins, :user_id
  end
end
