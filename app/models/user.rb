class User < ActiveRecord::Base
has_secure_password
has_many :trips
has_one :setting
has_one :balance
has_one :history
#attr_accessor :password, :password_confirmation are created with has_secure_password

validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
validates :given_name, presence: true
validates :family_name, presence: true
validates :country, presence: true, format: { with: /\A[A-Za-z][A-Za-z]\z/ }

before_save { downcase_email }

def downcase_email
	self.email = email.downcase
end

def generate_password_reset_token!
	update_attribute(password_reset_token, SecureRandom.urlsafe_base64(48))
end

end