class User < ActiveRecord::Base
  has_secure_password

  has_many :ideas, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :ideas_liked, through: :likes, source: :ideas

  validates :name, :alias, :email, presence: true
  validates :password, on: :create, length: { minimum: 8 }
  validates :email, uniqueness: true, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }
  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end
end
