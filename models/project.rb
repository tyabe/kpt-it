class Project < ActiveRecord::Base

  # fields
  field :name,              as: :string
  field :description,       as: :text
  field :token,             as: :string
  field :crypted_password,  as: :string
  field :accept,            as: :boolean, default: true

  timestamps

  attr_accessor :password

  # validations
  validates_presence_of :name
  validates_presence_of :password, unless: :crypted_password?
  validates_length_of :name, in: 0..30

  # referenced
  has_many :posts, dependent: :destroy

  # callbacks
  before_create :generate_token, :encrypt_password

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  private

  def generate_token
    loop do
      self.token = SecureRandom.hex
      break unless self.class.where(token: self.token).first
    end
  end

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password)
  end

end
