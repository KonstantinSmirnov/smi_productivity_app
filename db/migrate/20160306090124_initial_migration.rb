class InitialMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # Sorcery core
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      # Additional fields
      t.string :name
      t.string :title
      t.attachment :avatar

      t.timestamps
    end

    add_index :users, :email, unique: true

    create_table :projects do |t|
      t.integer :user_id
      t.string :title
      t.string :description #optional

      t.timestamps
    end

    create_table :tasks do |t|
      t.integer :project_id
      t.string :title
      t.boolean :done?, default: false
      t.string :description

      t.timestamps
    end

    create_table :comments do |t|
      t.integer :task_id
      t.integer :user_id
      t.string :text

      t.timestamps
    end
  end
end
