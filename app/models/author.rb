class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]
  has_many :posts, dependent: :destroy
  has_many :articles, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |author|
      author.email = auth.info.email
      author.password = Devise.friendly_token[0, 20]
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # author.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |author|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        author.email = data['email'] if author.email.blank?
      end
    end
  end
end
