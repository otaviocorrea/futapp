class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.integer :role, default: 0
      
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      
      t.string :phone, index: true
      t.string :instagram, index: true
      t.string :picture

      t.string :cpf, index: { unique: true }

      t.timestamps
    end
  end
end
