class User < ApplicationRecord
    validates :password, {presence: true}
    validates :email, {presence: true}
    validates :name, {presence: true}
end
