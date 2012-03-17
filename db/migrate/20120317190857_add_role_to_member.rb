class AddRoleToMember < ActiveRecord::Migration
  def change
    change_table :members do |t|
      t.string :role, :default => "grunt", :null => false
    end
  end
end
