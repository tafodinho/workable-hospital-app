class DashboardsController < ApplicationController 
  layout 'dashboard'
  def index
    days = params[:days].present? ? params[:days].to_i : 7

    @registrations = Patient.where(created_at: days.days.ago..Time.now).group("DATE(created_at)").count
    @formatted_registrations = @registrations.map { |date, count| {x: date.to_s, y: count} }
    @total_patients = Patient.count
    @total_users = User.count

    respond_to do |format|
      format.html { render template: "dashboard/index" }
      format.json { render json: @formatted_registrations }
    end
    # 
  end
end