class AddPaperclipToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :document_file_name, :string
    add_column :letters, :document_content_type, :string
    add_column :letters, :document_file_size, :integer
    add_column :letters, :document_updated_at, :datetime
  end
end
