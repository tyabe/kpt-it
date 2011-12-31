class Project
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # fields
  field :name, type: String
  field :description, type: String
  field :token, type: String

  # validations
  validates_presence_of :name
  validates_length_of :name, in: 0..30

  # referenced
  belongs_to :author, class_name: "Account"
  has_many :posts, dependent: :delete

  before_create :generate_token

  protected

  def generate_token
    loop do
      self.token = SecureRandom.hex
      break unless self.class.where(token: self.token).first
    end
  end

end
