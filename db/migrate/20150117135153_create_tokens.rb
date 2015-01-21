class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.integer :client_id
      t.string :identification
      t.string :token_key
      t.boolean :active
      t.timestamps
    end
  end
end
