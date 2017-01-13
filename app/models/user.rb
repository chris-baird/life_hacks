class User < ActiveRecord::Base
  has_many :hacks
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
