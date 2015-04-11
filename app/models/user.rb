class User < ActiveRecord::Base
has_many :trips
has_secure_password
#attr_accessor :password, :password_confirmation are created with has_secure_password

validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
validates :given_name, presence: true
validates :family_name, presence: true
validates :country, presence: true, format: { with: /\A[A-Za-z][A-Za-z]\z/ }

def generate_password_reset_token
	update_attribute(password_reset_token, SecureRandom.urlsafe_base64(48))
end

#Have to do a case-insensitive email check, so easier to just downcase everything. Sorry, users.
def downcase_email
	self.email = email.downcase
end

before_save downcase_email

end
