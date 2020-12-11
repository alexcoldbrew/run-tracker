class User < ActiveRecord::Base
    has_many :runs
    has_secure_password
    validates :username, presence: true
    validates :email, presence: true
    
    validates :username, uniqueness: true
end