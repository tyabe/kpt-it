class Project < ActiveRecord::Base

  # fields
  field :name,              as: :string
  field :description,       as: :text
  field :token,             as: :string
  field :crypted_password,  as: :string
  field :accept,            as: :boolean, default: true

  field :created_at, :updated_at, as: :datetime

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
    value = ::BCrypt::Password.create(password)
    value = value.force_encoding(Encoding::UTF_8) if value.respond_to?(:encoding) && value.encoding == Encoding::ASCII_8BIT
    self.crypted_password = value
  end

end
