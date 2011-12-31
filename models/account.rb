class Account
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # fields
  field :role,              type: String
  field :provider,          type: String
  field :uid,               type: String

  field :name,              type: String
  field :screen_name,       type: String
  field :description,       type: String
  field :profile_image_url, type: String

  attr_accessible :name, :screen_name, :description, :profile_image_url

  # referenced
  has_many :projects, inverse_of: :author, dependent: :delete
  has_many :posts, inverse_of: :author, dependent: :delete

  class << self

    def find_by_id(id)
      find(id) rescue nil
    end

    def create_with_omniauth(auth)
      create! do |account|
        account.role = "users"

        account.provider = auth["provider"]
        account.uid = auth["uid"]

        account.name = auth["info"]["name"]
        account.screen_name = auth["info"]["nickname"]
        account.description = auth["info"]["description"]
        account.profile_image_url = auth["info"]["image"]
      end
    end

  end

end
