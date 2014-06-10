class AlertsController < ApplicationController
  
  before_filter :correct_user, only: [:delete_all, :destroy]
  
  def destroy
    @alert.destroy
    redirect_to root_path
  end
  
  def delete_all
    @alerts.each do |a|
      a.destroy
    end
    redirect_to root_path
  end
  
  private
  
    #Only allow delete function to delete current user's alerts
    def correct_user
      #Ignore friend request alerts since those persist until user makes decision
      @alerts = current_user.alerts.where("friend_id IS NULL")
      @alert = current_user.alerts.find_by_id(params[:id])
      redirect_to root_path if @alerts.nil?
    end
end
