class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
    # if current_user.profile
    #   format.html {redirect_to @profile}
    # else
    #   format.html {redirect_to new_profile_path}
    # end
    # @profileswithlat = @profiles.where
    @hash = Gmaps4rails.build_markers(@profiles.where.not(latitude: nil)) do |profile, marker|
      if profile.latitude
      marker.lat profile.latitude
      marker.lng profile.longitude
      marker.infowindow profile.first_name + " " + profile.last_name
      end
    end

  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show

  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    # authorize! :edit, @profile
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    respond_to do |format|
      if @profile.save
        if @profile.user.has_role? :owner
          format.html { redirect_to new_pet_path, notice: 'Welcome ' + @profile.first_name + '! Your profile was successfully created. Tell us about your pet!' }
        else
          format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        end
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :street, :suburb, :postcode, :state, :country, :phone, :photo, :user_id)
    end
end
