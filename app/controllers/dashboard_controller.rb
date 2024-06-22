class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @dashboard_service = DashboardService.new(current_user)
  end

  def active_people_pie_chart
    @dashboard_service.active_people_pie_chart
  end

  def total_debts
    @dashboard_service.total_debts
  end

  def total_payments
    @dashboard_service.total_payments
  end

  def amount
    @dashboard_service.amount
  end

  def last_debts
    @dashboard_service.last_debts
  end

  def last_payments
    @dashboard_service.last_payments
  end

  def my_people
    @dashboard_service.my_people
  end

  def top_person
    @dashboard_service.top_person
  end

  def bottom_person
    @dashboard_service.bottom_person
  end
  
  def last_large_debts
    @last_large_debts = @dashboard_service.last_large_debts
  end
end