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
      #Shows current selected organisation
      t.integer :workspace_id

      t.timestamps null: false
    end

    add_index :users, :email, unique: true

    create_table :workspaces do |t|
      t.string :title

      t.timestamps null: false
    end

    create_table :connections do |t|
      t.integer :user_id
      t.integer :workspace_id
      t.integer :role, default: 0

      t.timestamps null: false
    end
    add_index :connections, [:user_id, :workspace_id], unique: true

    create_table :projects do |t|
      t.integer :workspace_id
      t.string :title
      t.string :description
      t.integer :condition, default: 0

      t.timestamps null: false
    end

    create_table :tasks do |t|
      t.integer :project_id
      t.string :title
      t.date :due_date
      t.boolean :done?, default: false
      t.string :description

      t.timestamps null: false
    end

    create_table :comments do |t|
      t.integer :task_id
      t.integer :user_id
      t.string :text

      t.timestamps null: false
    end

    create_table :statuses do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :color
      t.string :text

      t.timestamps null: false
    end
  end
end
