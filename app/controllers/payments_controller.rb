class PaymentsController < ApplicationController
  before_filter :authenticate_user
  before_filter :payment_permissions?
  around_filter :oauth_exception, only:[:create, :mtan_confirm, :mtan, :update]
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :load_oauth
  layout "mtan", only: [:mtan]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.joins(:account,:status).where(accounts: {customer_id:session[:id]}).
                  page(params[:page])
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
	  @payment = Payment.find(params[:id])
  end

  # GET /payments/new
  def new
    @accounts = Account.where(:customer_id=> session[:id])
    @payment = Payment.new
    status  = Status.where(:name=>Constants::PAYMENT_CREATED_STATUS).first
    @payment.status = status
  end

  # GET /payments/1/edit
  def edit
    @accounts = Account.where(:customer_id=> session[:id])
    @payment = Payment.find(params[:id])
    status  = Status.where(:name=>Constants::PAYMENT_MODIFIED_STATUS).first
    @payment.status = status
  end

  # POST /payments
  # POST /payments.json
  def create
    @account = Account.find(payment_params[:account_id])
    @account_detail = @client.get_account_detail(@account.account_fidor_id)
    @payment = Payment.new(payment_params)
    if @account_detail.can_transfer?(payment_params['amount'])
      @payment.account = @account
      status  = Status.where(:name=>Constants::PAYMENT_CREATED_STATUS).first
      @payment.status = status
      @payment.uuid = SecureRandom.uuid
      respond_to do |format|
        if @payment.save
          format.html { redirect_to mtan_payment_path(@payment) }
        else
          format.html { render :new }
        end
      end  
    else
      @payment.errors.add(:base, " Amount unavailable ")
      respond_to do |format|
        format.html { render :new }
      end
    end

  end
  
  
  def mtan 
	  @payment = Payment.find(params[:id])
    @client.request_mtan(@payment)
  end
  
  def mtan_confirm

    @payment = Payment.find(params[:id])
    @account_detail = @client.get_account_detail(@payment.account.account_fidor_id)
    if @account_detail.can_transfer?(@payment.amount)
      if @client.mtan_valid?(params[:mtan])
        if @payment.can_complete?
          id = @client.post_payment(@payment)
          @payment.transaction_number = id
          status  = Status.where(:name=>Constants::PAYMENT_COMPLETED_STATUS).first
          #obtengo el id de la transaccion
          flash[:notice] = 'This Payment has been procesed ' #todo to locale
        else
          status  = Status.where(:name=>Constants::PAYMENT_2MC_CHECKED_STATUS).first
          flash[:notice] = 'This Payment its configured by TMR and must be Approved ' #todo to locale
        end
        @payment.status = status
        @payment.save
        redirect_to :payment
      else
        flash[:notice] = 'Invalid MTAN ' #todo to locale
        redirect_to mtan_account_payment_path(@account,@payment)
      end
    else
      flash[:notice] = 'Amount unavailable ' #todo to locale
      redirect_to edit_account_payment_path(@account,@payment)
    end

  end

  def to_approve  # lista de payments pendientes de mi aprobacion
    @payments = Payment.joins(:account,:status).where(accounts: {approver_id:session[:id]}).
                  where(statuses:{ name: "2mc_checked"}).page(params[:page])
    render "index"
  end

  def for_approval # lista de payments pendientes de aprobacion de otros
    @payments = Payment.joins(:account,:status).where(accounts: {two_man_rule:true}).
                  where.not(accounts: {approver_id:session[:id]}).
                  where(statuses:{ name: "2mc_checked"}).page(params[:page])
    render "index"
  end

  def deny
    @accounts = Account.where(:customer_id=> session[:id])
    @payment = Payment.find(params[:id])
    status = Status.where(:name=>Constants::PAYMENT_2MC_DENIED_STATUS).first
    @payment.status = status
    render "edit"
  end

  def approve
    @payment = Payment.find(params[:id])
    redirect_to mtan_payment_path(@payment)
  end


  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update

	  @payment = Payment.find(params[:id])
    status = Status.find(payment_params[:status_id])
    @payment.status = status
    @account = Account.find(payment_params[:account_id])
    if @payment.is_denied?
      respond_to do |format|
        if @payment.update(payment_params)
          format.html { redirect_to payments_path }
        else
          format.html { render :edit }
        end
      end
    else
      @account_detail = @client.get_account_detail(@account.account_fidor_id)
      if @account_detail.can_transfer?(payment_params['amount'])
        respond_to do |format|
          if @payment.update(payment_params)
            format.html { redirect_to mtan_payment_path(@payment) }
          else
            format.html { render :edit }
          end
        end
      else
        @payment.errors.add(:base, " Amount unavailable ")
        respond_to do |format|
          format.html { render :edit }
        end
      end
    end

  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
     params.require(:payment).permit(:account_id, :iban, :bic, :status_id, 
              :amount,:txt_reference,:name,:txt_rejected_reference)
    end
	
	
  def oauth_exception
    begin
      yield
    rescue ActiveRecord::RecordNotFound => error
      flash[:error] = error.instance_values
      respond_with @account_detail
    rescue Exceptions::OAuthConnError, Exceptions::OAuthHTTPStatusError => error
      flash[:error] = error.instance_values
      respond_with @account_detail
    rescue Exceptions::OAuthProcessStatusError => error
      redirect_to logout_url, :notice => error.message
    end
  end
  
end
