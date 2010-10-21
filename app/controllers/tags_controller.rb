class TagsController < ApplicationController
  before_filter :authorize

  def index
  	@tags = Tag.all
  	if @tags.empty?
  	  flash[:notice] = "No tags in database."
  	end
  	respond_to do |format|
  	  format.html
  	  format.xml { render :xml => @tags.to_xml }
  	end
  end

  def search
  	@tags = []
  	if params[:keyword]
  	  @tags = Tag.find.all(:conditions => ["title LIKE ?" , "%#{params[:keyword]}%"])
  	  if @tags.empty?
  		flash[:notice] = "No such tags in database."
  	  end
  	end
  end

  def show
  	@tag = Tag.find(params[:id])
  	respond_to do |format|
  	  format.html
  	  format.xml { render :xml => @tag.to_xml }
  	end
  end

  def new
	 @tag = Tag.new
  end

  def edit
	 @tag = Tag.find(params[:id])
  end

  def create
  	@tag = Tag.new(params[:tag])
  	if @tag.save
  	  flash.now[:notice] = "Tag was successfully created."
  	  redirect_to :action => 'index'
  	end
  end

  def update
  	@tag = Tag.find(params[:id])
  	if @tag.update_attributes(params[:tag])
  	  flash[:notice] = "Tag was successfully updated."
  	  redirect_to :action => 'index'
  	end
  end

  def generate
  	Section.all.each do |s|
  	  tag = Tag.new({:title => s.title, :description => "Tag for section #{s.title}"})
  	  tag.save
  	end
  	Project.all.each do |p|
  	  tag = Tag.new({:title => p.title, :description => "Tag for project #{p.title}"})
  	  tag.save
  	end
  	#["Upravni odbor", "Nadzorni odbor", "Voditelji"].each do |x|
  	#  tag = Tag.new({:title => x, :description => "Tag for #{x}"})
  	#  tag.save
  	#end
  	redirect_to tags_url
  end

  def destroy
  	@tag = Tag.find(params[:id])
  	if @tag.destroy
  	  flash[:notice] = 'Tag was successfully deleted.'
  	  redirect_to :action => 'index'
  	end
  end

end
