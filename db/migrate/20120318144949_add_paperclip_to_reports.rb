class AddPaperclipToReports < ActiveRecord::Migration
  def change
    add_column :reports, :document_file_name, :string
    add_column :reports, :document_content_type, :string
    add_column :reports, :document_file_size, :integer
    add_column :reports, :document_updated_at, :datetime
  end
end
