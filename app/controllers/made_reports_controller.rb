class MadeReportsController < ApplicationController


  def create
  	@made_report = current_user.made_reports.build(made_report_params)

    if @made_report.save
      redirect_to(recipe_path(@made_report.recipe_id))
    else
      render 'new'
    end

  end

  def destroy
   @made_report.destroy
   # respond_to do |format|
   #  format.html { redirect_to made_reports_url }
   #  format.json { head :no_content }
   redirect_to(recipe_path(@made_report.recipe_id))
   end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_made_report
      @made_report = MadeReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def made_report_params
      params.require(:made_report).permit(:message, :image, :recipe_id)
    end

