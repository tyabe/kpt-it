require 'spec_helper'

describe Project do
  describe 'validations' do
    it 'valid with a name and password' do
      expect(Project.new(name: 'test_project', password: 'secret')).to be_valid
    end
    it 'invalid without a name' do
      expect(Project.new(password: 'secret').errors_on(:name).size).to eql 1
    end
    it 'invalid without a password' do
      expect(Project.new(name: 'test_project').errors_on(:password).size).to eql 1
    end
    it 'is invalid if length of name is less than 0' do
      expect(Project.new(name: '', password: 'secret').errors_on(:name).size).to eql 1
    end
    it 'is invalid if length of name is greater than 30' do
      expect(Project.new(name: '_'.tap{|c|6.times{c<<'test_'}}, password: 'secret').errors_on(:name).size).to eql 1
    end
  end
  describe 'relations' do
    it 'has many posts' do
      expect(Project.reflect_on_all_associations(:has_many).map(&:name)).to include(:posts)
    end
  end
  describe 'callbacks' do
    it 'generate token when model is created' do
      project = Project.create(name: 'test_project', password: 'secret')
      expect(project.token).to be_present
    end
    it 'generate crypted password when model is created' do
      project = Project.create(name: 'test_project', password: 'secret')
      expect(project.crypted_password).to be_present
    end
  end
  describe '.has_password?' do
    it 'can check password match' do
      project = Project.create(name: 'test_project', password: 'secret')
      expect(project).to be_has_password('secret')
    end
  end
end
