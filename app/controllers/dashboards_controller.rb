class DashboardsController < ApplicationController
  # GET /dashboards
  # GET /dashboards.json
  def index
   if current_user
    @dashboards = Dashboard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dashboards }
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
   if current_user
    @dashboard = Dashboard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dashboard }
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # GET /dashboards/new
  # GET /dashboards/new.json
  def new
   if current_user
    @dashboard = Dashboard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dashboard }
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # GET /dashboards/1/edit
  def edit
   if current_user
    @dashboard = Dashboard.find(params[:id])
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
   if current_user
    @dashboard = Dashboard.new(params[:dashboard])

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Gratulacje! Stworzono notatke' }
        format.json { render json: @dashboard, status: :created, location: @dashboard }
      else
        format.html { render action: "new" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # PUT /dashboards/1
  # PUT /dashboards/1.json
  def update
   if current_user
    @dashboard = Dashboard.find(params[:id])

    respond_to do |format|
      if @dashboard.update_attributes(params[:dashboard])
        format.html { redirect_to @dashboard, notice: 'Gratulacje! Zaktualizowano notatke' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
   if current_user
    @dashboard = Dashboard.find(params[:id])
    @dashboard.destroy

    respond_to do |format|
      format.html { redirect_to dashboards_url }
      format.json { head :no_content }
    end
   else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end
end
