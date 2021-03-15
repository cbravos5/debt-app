class User < ApplicationRecord

    has_secure_password
    # validates_confirmation_of :password
    validates :username, uniqueness: true 
    attr_reader :password
    attr_accessor :password_confirmation

end
