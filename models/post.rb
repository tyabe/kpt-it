class Post < ActiveRecord::Base

  # fields
  field :kind,  as: :string
  field :body,  as: :text
  field :token, as: :string

  field :created_at, :updated_at, as: :datetime

  # validations
  validates_presence_of :kind, :body

  # referenced
  belongs_to :project

  # scopes
  default_scope { order('created_at desc') }

  # callbacks
  before_create :generate_token

  private

  def generate_token
    loop do
      self.token = SecureRandom.hex
      break unless self.class.where(token: self.token).first
    end
  end

end
