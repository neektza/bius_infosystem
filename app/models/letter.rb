class Letter < ActiveRecord::Base
  # TYPE to avoid STI
  TYPE = {:incoming => 'i', :outgoing => 'o'}

  validates_presence_of :in_out
  validates_presence_of :filename
  validates_presence_of :delivery_number
  validates_uniqueness_of :delivery_number
  
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

