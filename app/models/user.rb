class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :lyrics, dependent: :destroy
    has_many :beats, dependent: :destroy
    has_many :events, dependent: :destroy
    enum status: [ :comum_user, :half_admin, :full_admin, :editor, :beatmaker ]
    validates :name, presence: true

end
