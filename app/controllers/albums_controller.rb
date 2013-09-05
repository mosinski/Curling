# encoding: UTF-8
class AlbumsController < ApplicationController


  def show
    @album = Album.find(params[:id])
    @zdjecia = Image.find_all_by_nr_albumu(@album.id).paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end


  def new
   if current_user
    if current_user.role == "admin"
    
    	@album = Album.new

    	respond_to do |format|
      		format.html # new.html.erb
      		format.json { render json: @album }
    	end
    		
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end


  def edit
   if current_user
    if current_user.role == "admin"
   	@album = Album.find(params[:id])
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end


  def create
   if current_user
    if current_user.role == "admin"
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
          @album.przydzial_id = @album.id
          @album.save
        format.html { redirect_to @album, notice: "Gratulacje! Stworzono nowy album '#{@album.tytul}'" }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
   if current_user
    if current_user.role == "admin"
    
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: "Gratulacje! Zaktualizowano album '#{@album.tytul}" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
    
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
   if current_user
    if current_user.role == "admin"
    
    @album = Album.find(params[:id])
    @zdjecia_albumu = Image.find_all_by_nr_albumu(@album.id)
    @zdjecia_albumu.each {|r| r.destroy }
    @album.destroy

    respond_to do |format|
      format.html { redirect_to "/galeria", :notice => 'Gratulacje! Usunięto Album wraz z wszystkimi zdjęciami!'}
      format.json { head :no_content }
    end
    
    else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end
end
