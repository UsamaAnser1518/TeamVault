class PaymentDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def index
    today = Date.today
    @total_paid = current_user.payment_details.sum(:amount_paid)|| "N/A"

    @monthly_payments = {}
    previous_payment_dates.each do |previous_payment_date|
      amount_paid = current_user.payment_details.where(created_at: previous_payment_date).sum(:amount_paid)

      @monthly_payments[previous_payment_date.strftime("%B %Y")] = {
        paid: amount_paid || 0,
      }
    end
  end

  def new
    @payment_detail = @user.payment_details.new
  end

  def create
    @payment_detail = @user.payment_details.new(payment_detail_params)
    if @payment_detail.save
      update_user_total_fund
      redirect_to payment_details_path, notice: 'Payment successfully created.'
    else
      render :new
    end
  end

  def update_user_total_fund
    prev_total_fund_paid = current_user.total_fund_paid || 0
    prev_total_fund_due = current_user.total_fund_due || 0
    current_user.update(total_fund_paid: (prev_total_fund_paid + @payment_detail.amount_paid), total_fund_due: (prev_total_fund_due - @payment_detail.amount_paid) )
  end

  private

  def set_user
    @user = current_user
  end

  def payment_detail_params
    params.require(:payment_detail).permit(:amount_paid)
  end

  def previous_payment_dates
    # (0..4).map { |i| Date.today.prev_month(i) }
    PaymentDetail.where(user_id: current_user.id).where.not(amount_paid: 0).order(created_at: :desc).pluck(:created_at)
  end
end
