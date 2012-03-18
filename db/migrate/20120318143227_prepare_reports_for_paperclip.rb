class PrepareReportsForPaperclip < ActiveRecord::Migration
  def change
    remove_column :reports, :data
    remove_column :reports, :content_type
    remove_column :reports, :filename
    remove_column :reports, :stamp
    remove_column :reports, :size
    add_column :reports, :document_file_name, :string
    add_column :reports, :document_content_type, :string
    add_column :reports, :document_file_size, :integer
    add_column :reports, :document_updated_at, :datetime
  end
end
