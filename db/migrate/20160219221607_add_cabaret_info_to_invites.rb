class AddCabaretInfoToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :cabaret_info, :text
  end
end
