class User < ActiveRecord::Base
  has_secure_password
  
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  
  has_many :accounts
  has_many :items, through: :accounts

  class << self
    def from_omniauth(auth)
      user_info = auth.extra.raw_info

      User.where("uid = ? OR email = ?", auth.uid, user_info.email).first_or_initialize.tap do |user|
        unless user.provider
          user.provider = auth.provider
          user.uid      = auth.uid

          user.first_name = user_info.first_name
          user.last_name  = user_info.last_name
          user.email      = user_info.email
          user.password   = SecureRandom.hex(12) unless user.password_digest

          user.gender     = user_info.gender[0].upcase if user_info.gender
          user.birth_date = Date.strptime(user_info.birthday, "%m/%d/%Y") rescue nil
        end

        user.oauth_token      = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)

        user.save!
      end
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
