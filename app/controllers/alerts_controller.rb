class AlertsController < ApplicationController
  
  before_filter :correct_user, only: [:delete_all]
  
  def delete_all
	@alerts.each do |a|
	  a.destroy
	end
	redirect_to root_path
  end
  
  private
  
    def correct_user
	  @alerts = current_user.alerts.where("friend_id IS NULL")
      redirect_to root_path if @alerts.nil?
    end
end
