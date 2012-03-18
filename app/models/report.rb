class Report < ActiveRecord::Base
  has_attached_file :document,
    :path => ":rails_root/public/system/:class/:reportable/:instance_name/:basename.:extension",
    :url => "/system/:class/:reportable/:instance_name/:basename.:extension"

  before_post_process :image?

  belongs_to :reportable, :polymorphic => :true
  
  def image?
    !(document_content_type =~ /^image.*/).nil?
  end

  Paperclip.interpolates :class do |attachment, style|
    attachment.instance.class.to_s.pluralize.downcase
  end
  
  Paperclip.interpolates :reportable do |attachment, style|
    attachment.instance.reportable_type.pluralize.downcase
  end
  
  Paperclip.interpolates :instance_name do |attachment, style|
    attachment.instance.reportable.title.parameterize.underscore
  end
end
