class Report < ActiveRecord::Base
  belongs_to :reportable
  
  def file=(stream)
    self.filename = base_part_of(stream.original_filename)
    self.content_type = stream.content_type
    self.size = stream.size
    self.data = stream.read
  end

  private

  def base_part_of(file_name)
      File.basename(file_name).gsub(/[^\w._-]/, '' )
  end
end
