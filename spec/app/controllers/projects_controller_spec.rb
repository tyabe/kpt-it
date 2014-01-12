require 'spec_helper'

describe "ProjectsController" do
  let(:project_token){ project.token }
  let(:project)      { Project.create!(name: project_name, password: "password") }
  let(:project_name) { "project_name" }

  describe "get '/:project_token'" do
    before do
      get "/#{project_token}"
    end

    it "return success code" do
      last_response.should be_ok
    end

    it "body should contains project name" do
      expected_html = "<h1>#{project_name}</h1>"
      last_response.body.should include expected_html
    end
  end

  describe "get '/:project_token.md'" do
    before do
      get "/#{project_token}.md"
    end

    it "return success code" do
      last_response.should be_ok
    end

    it "body should contains project name" do
      expected_markdown = <<MARKDOWN
# #{project_name}
MARKDOWN
      last_response.body.should include expected_markdown
    end
  end
end
