class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
   if current_user
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
   if current_user
    redirect_to root_url, :notice => 'Informacja! Wyloguj si&#281; aby dokona&#263; rejestracji'
   else
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
   end
  end

  # GET /users/1/edit
  def edit
    if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # POST /users
  # POST /users.json
def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save_without_session_maintenance 
        format.html { redirect_to( root_url, :notice => '<h4>Informacja!</h4> Konto zarejestrowane!.<br>Twoje konto czeka teraz na potwierdzenie przez Administratora.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
end

  # PUT /users/1
  # PUT /users/1.json
  def update
   if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def potwierdz
    @user = User.find(params[:id])
    if @user.potwierdzenie == 0 && current_user.role == "admin"
    @user.increment!(:potwierdzenie)
    end
    redirect_to users_path, :notice => 'Informacja! U&#380;ytkownik zosta&#322; potwierdzony'
  end

  def odwolaj
    @user = User.find(params[:id])
    if @user.potwierdzenie == 1 && current_user.role == "admin"
    @user.decrement!(:potwierdzenie)
    end
    redirect_to users_path, :notice => 'Informacja! U&#380;ytkownik zosta&#322; odwo&#322;any'	
  end
end
