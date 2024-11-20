class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum status: {
    inactive: 0,
    active: 1
  }

  enum rank: {
    ASE: 0,
    SE: 1,
    SSE: 2,
    ATL: 3,
    TL: 4,
    APM: 5,
    PM: 6,
    DIRECTOR: 7,
    PSE: 8
  }
end
