class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.integer :client_id
      t.integer :token_id
      t.string :type,  default: 'Auth'      
      t.string :access_token
      t.boolean :expired, default: false
      t.datetime :expires_at
      t.timestamps
    end
  end
end
