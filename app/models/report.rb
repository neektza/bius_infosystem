class Report < ActiveRecord::Base
  before_post_process :image?

  belongs_to :reportable, :polymorphic => :true
  has_attached_file :document
  
  def image?
    !(data_content_type =~ /^image.*/).nil?
  end
end
