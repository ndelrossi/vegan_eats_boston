class Admin::DashboardsController < AdminsController
  def index
    @admin_dashboard = AdminDashboard.new(params, num_per_page: 20)
  end
end
