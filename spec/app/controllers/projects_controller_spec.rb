require 'spec_helper'

describe "ProjectsController" do
  describe "get '/:project_token'" do
    before do
      get "/#{project_token}"
    end

    let(:project_token){ project.token }
    let(:project)      { Project.create!(name: project_name, password: "password") }
    let(:project_name) { "project_name" }

    it "return success code" do
      last_response.should be_ok
    end

    it "body should contains project name" do
      expected_html = <<HTML
<h1>#{project_name}</h1>
HTML
      last_response.body.should include expected_html
    end
  end
end
