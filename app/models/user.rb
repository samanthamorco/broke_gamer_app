class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wishes
  has_many :deals
  has_many :reviews
  belongs_to :role

  def admin?
    role.id == 1
  end

  def mod?
    role.id == 3
  end
end
