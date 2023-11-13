class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :trackable

  validates :username, :password, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :user, -> { where(role: 'user' )}

  before_validation :add_role_user

  def as_json_email
    {
      email: email,
      username: username
    }
  end

  private

  def add_role_user
    total = User.count
    self.role = total < 1 ? 'admin' : 'user'
  end
end