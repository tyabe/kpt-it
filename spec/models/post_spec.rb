require 'spec_helper'

describe Post do
  describe 'validations' do
    it 'valid with a kind and body' do
      expect(Post.new(kind: 'keep', body: 'test')).to be_valid
    end
    it 'invalid without a kind' do
      expect((Post.new(body: 'test')).errors_on(:kind).size).to eql 1
    end
    it 'invalid without a body' do
      expect((Post.new(kind: 'keep')).errors_on(:body).size).to eql 1
    end
  end
  describe 'relations' do
    it 'belongs to project' do
      expect(Post.reflect_on_all_associations(:belongs_to).map(&:name)).to include(:project)
    end
  end
  describe 'callbacks' do
    it 'generate token when model is created' do
      post = Post.create(kind: 'keep', body: 'test')
      expect(post.token).to be_present
    end
  end
end
