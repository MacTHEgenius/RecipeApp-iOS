class AddAuthentificationTokenToUser < ActiveRecord::Migration
  def change
    add_column :authors, :auth_token, :string, default: ''
    add_index :authors, :auth_token, unique: true
  end
end
