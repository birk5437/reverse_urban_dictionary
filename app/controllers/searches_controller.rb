class SearchesController < ApplicationController

  # GET /searchs
  # GET /searchs.json
  def index

  end

  # GET /searchs/1
  # GET /searchs/1.json
  def show
  end

  # GET /searchs/new
  def new
    @search = Search.new
  end

  # GET /searchs/1/edit
  def edit
  end

  # POST /searchs
  # POST /searchs.json
  def create
    @search = Search.new(search_params)
    raise @search.inspect

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searchs/1
  # PATCH/PUT /searchs/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searchs/1
  # DELETE /searchs/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searchs_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  #->Prelang (voting/acts_as_votable)
  def vote

    direction = params[:direction]

    # Make sure we've specified a direction
    raise "No direction parameter specified to #vote action." unless direction

    # Make sure the direction is valid
    unless ["like", "bad"].member? direction
      raise "Direction '#{direction}' is not a valid direction for vote method."
    end

    @search.vote_by voter: current_user, vote: direction

    redirect_to action: :index
  end

  private ##################################################################################################################################

  # TODO: use declarative_authorization gem when roles/CRUD gets more complex
  def redirect_unless_admin
    redirect_to root_path unless current_user && current_user.admin?
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:query)
    end
end
