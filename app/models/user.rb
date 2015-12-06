class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :ensure_authentication_token

  has_and_belongs_to_many :items

  def ensure_authentication_token
    if self.authentication_token.blank?
      self.authentication_token = self.generate_authentication_token
    end
  end

  def generate_authentication_token
    begin
      token = Devise.friendly_token
    end while User.exists?(authentication_token: token)
    return token
  end
end
