class InitialMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # Sorcery core
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      # Additional fields
      t.string :name

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
