class RemoveAuthColumnsFromMembers < ActiveRecord::Migration
  def change
    change_table :members do |t|
      t.remove :salt
      t.remove :hash_pass
      t.remove :auth_level
    end
  end
end
