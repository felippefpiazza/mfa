class AddFoneToClient < ActiveRecord::Migration
  def change
    add_column :clients, :phone2sms, :string    
  end
end
