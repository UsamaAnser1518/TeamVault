class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.full_name
      user.avatar_url = auth.info.image
      # user.skip_confirmation!
    end
  end

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
