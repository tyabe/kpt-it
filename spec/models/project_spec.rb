require 'spec_helper'

describe "Project Model" do
  let(:project) { Project.new }
  it 'can be created' do
    project.should_not be_nil
  end
end
