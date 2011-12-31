class Post
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # fields
  field :type, :type => String
  field :body, :type => String

  # validations
  validates_presence_of :type, :body

  # referenced
  belongs_to :author, class_name: "Account"
  belongs_to :project

end
