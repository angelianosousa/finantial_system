class UsersBackoffice::DashboardController < UsersBackofficeController

  def index
    params[:q] ||= { user_profile_id_eq: current_user.user_profile.id, date_gteq: Date.today.beginning_of_month, date_lteq: Date.today.end_of_month }

    @q = Transaction.ransack(params[:q])

    @transactions = @q.result(distinct: true).includes(:account, :category)

    @balance = @transactions.recipes.sum(:price_cents) - @transactions.expenses.sum(:price_cents)
  end
end
