class Letter < ActiveRecord::Base
  before_post_process :image?
  has_attached_file :document

  validates_presence_of :in_out
  validates_presence_of :filename
  validates_presence_of :delivery_number
  validates_uniqueness_of :delivery_number
  validates_format_of :delivery_number, :with => /\A\d{2}-\d{3}\Z/, :message => "Format je xx-yyy (god-rbr)."
  
  # TYPE to avoid STI
  TYPE = {:incoming => 'i', :outgoing => 'o'}

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
  
  def image?
    !(data_content_type =~ /^image.*/).nil?
  end
end

