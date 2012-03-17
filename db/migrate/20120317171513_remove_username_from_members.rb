class RemoveUsernameFromMembers < ActiveRecord::Migration
  def change
    change_table :members do |t|
      t.remove :username
    end
  end
end
