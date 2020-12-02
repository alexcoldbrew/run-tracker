class Run < ActiveRecord::Base
    belongs_to :user
    validates :date, presence: true
    validates :distance, presence: true
    validates :hours, presence: true
    validates :minutes, presence: true
    validates :seconds, presence: true
end