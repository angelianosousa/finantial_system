class UsersBackoffice::TransactionsController < UsersBackofficeController
  before_action :set_transaction, only: %i[ edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    if params[:title]
      @transactions = Transaction._search_transactions(params[:title], current_user.user_profile.id, params[:page])
    elsif params[:recurrence_id]
      @transactions = Transaction._search_transactions_per_recurrence(params[:recurrence_id], current_user.user_profile.id, params[:page])
    else
      @transactions = Transaction.order(date: :asc).where(user_profile: current_user.user_profile).includes(:recurrence => :category).page(params[:page])
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_profile = current_user.user_profile
    @transaction.category = Recurrence.find(@transaction.recurrence_id).category

    respond_to do |format|
      if @transaction.save!
        format.html { redirect_to users_backoffice_transactions_url, notice: "Transação criada com sucesso!" }
        format.json { render :index, status: :created, location: @transaction }
      else
        format.html { redirect_to users_backoffice_transactions_url, alert: @transaction.errors.full_messages }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to users_backoffice_transactions_url, notice: "Transação atualizada com sucesso!" }
        format.json { render :index, status: :ok, location: @transaction }
      else
        format.html { render :edit, alert: @transaction.errors.full_messages }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to users_backoffice_transactions_url, notice: "Transação apagada com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:recurrence_id, :category_id, :title, :price_cents, :date)
    end
end
