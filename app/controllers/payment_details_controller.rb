class PaymentDetailsController < ApplicationController
  def index
    today = Date.today
    @total_paid = current_user.payment_details.sum(:amount_paid)|| "N/A"
    @total_due = current_user.payment_details.sum(:amount_due)|| "N/A"
    @month_paid = current_user.payment_details.where(submission_month: today.strftime("%B")).last.amount_paid || "N/A"
    @month_due = current_user.payment_details.where(submission_month: today.strftime("%B")).last.amount_due || "N/A"

    @monthly_payments = {}

    last_five_months.each do |month|
      payment = current_user.payment_details.find_by(submission_month: month.strftime("%B"))

      @monthly_payments[month.strftime("%B %Y")] = {
        paid: payment&.amount_paid || 0,
        due: payment&.amount_due || 0
      }
    end
  end

  private

  def last_five_months
    (0..4).map { |i| Date.today.prev_month(i) }
  end
end
