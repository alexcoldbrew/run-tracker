class Run < ActiveRecord::Base
    belongs_to :user
    validates :date, :distance, :hours, :minutes, :seconds, presence: true
end