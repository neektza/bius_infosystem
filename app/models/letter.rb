class Letter < ActiveRecord::Base
  # TYPE to avoid STI
  TYPE = {:incoming => 'i', :outgoing => 'o'}

  validates_presence_of :in_out
  validates_presence_of :filename
  validates_presence_of :delivery_number
  validates_uniqueness_of :delivery_number
  validates_format_of :delivery_number, :with => /\A\d{2}-\d{3}\Z/, :message => "Format je xx-yyy (god-rbr)."
  
  def file=(stream)
    self.filename = base_part_of(stream.original_filename)
    self.content_type = stream.content_type
    self.size = stream.size
    self.data = stream.read
  end

  def self.next_outgoing_delivery_nmb
    last_dn = Letter.where(:in_out => TYPE[:outgoing]).maximum(:delivery_number)
    if last_dn
      parts = last_dn.split("-")
      if parts[0] == Date.today.year.to_s[2,3] #current year
        next_dn = last_dn.succ
      else # first letter in current year
        next_dn = Date.today.year.to_s[2,3] + "-" + "001"
      end
    else # the first letter
      next_dn = Date.today.year.to_s[2,3] + "-" + "001"
    end
    return next_dn
  end
  
  private
  def base_part_of(file_name)
      File.basename(file_name).gsub(/[^\w._-]/, '' )
  end
end

