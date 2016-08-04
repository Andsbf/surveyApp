class Api::V1::RowsController < ApplicationController
  before_action :set_field, only: [:show, :edit, :update, :destroy]

  def index
    @rows = Row.all
    render json: @rows
  end

  # # GET /fields/1
  # # GET /fields/1.json
  # def show
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @row }
  #   end
  # end

  # GET /fields/new
  def new
    @row = Row.new
    render json: @row
  end

  def create
    debugger
    @row = Row.where(id: row_params[:id]).first_or_create

    # debugger
    if @row.update(row_params)
      render json: @row
    else
      render json: @row.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /fields/1
  # # PATCH/PUT /fields/1.json
  # def update
  #   respond_to do |format|
  #     if @row.update(field_params)
  #       format.html { redirect_to @row, notice: 'Field was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @row.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /fields/1
  # DELETE /fields/1.json
  def destroy
    @row.destroy
    respond_to do |format|
      format.html { redirect_to fields_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_field
    @row = Row.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def row_params
    params.require(:row).permit(:id, :form_id, :label, :row_type, options: [:id, :value])
  end
end
