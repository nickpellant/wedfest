class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :invite_code, null: false

      t.timestamps null: false
    end
    add_index :invites, :invite_code, unique: true
  end
end
