class AlertsController < ApplicationController
  
  before_filter :correct_user, only: :destroy
  
  def destroy
    @alert.destroy
    redirect_to root_path
  end
  
  private
  
    def correct_user
      @alert = current_user.alerts.find_by_id(params[:id])
      redirect_to root_path if @alert.nil?
    end
end
