class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :lyrics, dependent: :destroy
    enum status: [ :comum_user, :half_admin, :full_admin ]
    validates :name, presence: true

end
