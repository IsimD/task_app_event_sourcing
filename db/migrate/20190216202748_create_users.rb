class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :auth_token
      t.timestamps

      t.timestamps
    end

    add_index :users, :auth_token, unique: true
    add_index :users, :email, unique: true
  end
end
