class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  #validates :email, presence:true, if: Proc.new { |a| a.email.present? }

  def email_required?
    false
  end
  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|

      user.provider = auth.provider
      user.uid = auth.uid
      password = Devise.friendly_token[0,20]
      user.password = password
      user.password_confirmation = password
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      #user.skip_confirmation!
    end
  end
end
