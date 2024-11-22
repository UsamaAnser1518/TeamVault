class PaymentDetail < ApplicationRecord
  belongs_to :user

  enum status: {
    pending: 0,
    submitted: 1
  }
end
