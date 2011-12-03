require 'spec_helper'

describe "Setting Model" do
  let(:setting) { Setting.new }
  it 'can be created' do
    setting.should_not be_nil
  end
end
