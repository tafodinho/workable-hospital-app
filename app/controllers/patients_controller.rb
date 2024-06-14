class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]
  layout 'dashboard'
  # GET /patients or /patients.json
  def index
    page = params[:page].present? ? params[:page].to_i : 1
    if params[:search].present?
      @patients = Patient.search(params[:search]).page(params[:page])
    else
      @patients = Patient.all.page(params[:page])
    end
    # @patients = Patient.page(page).per(30)
    @patient = Patient.new
    @total_patients = Patient.count
    @total_users = User.count
  end

  # GET /patients/1 or /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients or /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to patient_url(@patient), notice: "Patient was successfully created." }
        format.json { render :show, status: :created, location: @patient }
      else
        flash[:error] = @user.errors
        index
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patient_url(@patient), notice: "Patient was successfully updated." }
        format.json { render :show, status: :ok, location: @patient }
      else
        flash[:error] = @user.errors
        format.html { redirect_to patient_url(@patient), status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to patients_url, notice: "Patient was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :dob, :phone_number, :email, :address)
    end
end
