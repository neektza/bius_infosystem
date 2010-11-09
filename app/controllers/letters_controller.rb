class LettersController < ApplicationController
  before_filter :authorize

  def index
    @letters = Letter.all
    if @letters.empty?
        flash.now[:notice] = "No letters in database."
    end
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @letters.to_xml }
    end
  end
  
  def search
	@letters = []
	if params[:keyword]
	  @letters = Letter.all(:conditions => ["subject LIKE ?" , "%#{params[:keyword]}%"])
	  if @letters.empty?
		flash[:notice] = "messages.letters.search.empty"
	  end
	  respond_to do |format|
		format.html
		format.xml { render :xml => @letters.to_xml }
		format.json { render :json => @letters.to_json }
	  end
	end
  end

  def incoming
    @letters = Letter.all(:conditions => {:in_out => Letter::TYPE[:incoming]})
    if @letters.empty?
        flash.now[:notice] = "No such letters in database."
    end

    respond_to do |format|
      format.html { render "index" }
      format.xml { render :xml => @letters.to_xml }
    end
  end

  def outgoing
    @letters = Letter.all(:conditions => {:in_out => Letter::TYPE[:outgoing]})
    if @letters.empty?
        flash.now[:notice] = "No such letters in database."
    end

    respond_to do |format|
      format.html { render "index" }
      format.xml { render :xml => @letters.to_xml }
    end
  end

  def show
    @letter = Letter.find(params[:id])
  end
  
  def new
    @letter = Letter.new
    @next_dn = Letter.next_outgoing_delivery_nmb
  end
  
  def create
    @letter = Letter.new(params[:letter])
    if @letter.save
      flash.now[:notice] = "Letter was successfully created."
      redirect_to letters_url
    else
      render "new"
    end
  end

  def edit
    @letter = Letter.find(params[:id])
    @next_dn = Letter.next_outgoing_delivery_nmb
  end

  def update
    @letter = Letter.find(params[:id])
    if @letter.update_attributes(params[:letter])
      flash.now[:notice] = "Letter was successfully updated."
      redirect_to letter_url(@letter)
    else
      render "edit"
    end
  end  

  def destroy
    @letter = Letter.find(params[:id])
    if @letter.destroy
      flash[:notice] = "Letter was successfully deleted."
      redirect_to letters_url
    end
  end
  
  def download
    @letter = Letter.find(params[:id])
    send_data(@letter.data, :filename => @letter.filename, :type => @letter.content_type)
  end

end
