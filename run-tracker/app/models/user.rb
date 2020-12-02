class User < ActiveRecord::Base
    has_many :run
    validates :username, presence: true
    validates :email, presence: true
    validates :password, presence: true
    validates :username, uniqueness: true
end