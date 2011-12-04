require 'spec_helper'

describe "Post Model" do
  let(:post) { Post.new }
  it 'can be created' do
    post.should_not be_nil
  end
end
