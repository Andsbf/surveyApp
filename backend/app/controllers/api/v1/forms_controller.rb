class Api::V1::FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  respond_to :json
  # GET /forms
  # GET /forms.json
  def index
    @forms = Form.all

    respond_with @forms
  end

  # GET /forms/1
  # GET /forms/1.json
  def show
    render json: @form
  end

  # GET /forms/new
  def new
    @form = Form.new
    render json: @form
  end

  # POST /forms
  # POST /forms.json
  def create
    # debugger
    @form = Form.new(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: 'Form was successfully created.' }
        format.json { render json: @form, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms/1
  # PATCH/PUT /forms/1.json
  def update
    if @form.update(form_params)
      render json: @form
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.json
  def destroy
    @form.destroy
    respond_to do |format|
      format.html { redirect_to forms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.require(:form).permit(:form_id, :title)
    end
end
