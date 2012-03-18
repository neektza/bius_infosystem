class Letter < ActiveRecord::Base
  has_attached_file :document,
    :path => ":rails_root/public/system/:class/:in_out/:basename.:extension",
    :url => "/system/:class/:in_out/:basename.:extension"
  
  before_post_process :image?

  validates_presence_of :in_out
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

  def type
    if in_out == TYPE[:incoming]
      'incoming'
    else
      'outgoing'
    end
  end
  
  def image?
    !(document_content_type =~ /^image.*/).nil?
  end

  Paperclip.interpolates :class do |attachment, style|
    attachment.instance.class.to_s.pluralize.downcase
  end
  
  Paperclip.interpolates :in_out do |attachment, style|
    attachment.instance.type
  end
end

