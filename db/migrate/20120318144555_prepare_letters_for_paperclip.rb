class PrepareLettersForPaperclip < ActiveRecord::Migration
  def change
    remove_column :letters, :data
    remove_column :letters, :content_type
    remove_column :letters, :filename
    remove_column :letters, :size
  end
end
