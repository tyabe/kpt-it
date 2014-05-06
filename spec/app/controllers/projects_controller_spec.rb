require 'spec_helper'

describe "ProjectsController" do
  let(:app)           { KptIt::App }
  let(:project)       { Project.create!(project_attr) }
  let(:project_token) { project.token }
  let(:project_name)  { "project_name" }
  let(:project_attr)  { { name: project_name, password: "password" } }

  describe "GET '/new'" do
    before { request_to :get, '/new' }
    it { expect(last_response).to be_ok }
  end

  describe "POST '/new'" do
    context 'non parameters' do
      before { request_to :post, '/new' }
      it { expect(last_response).to be_ok }
    end
    context 'with parameteres' do
      before { request_to :post, '/new', { project: project_attr } }
      it { expect(last_response).to be_redirect }
    end
  end

  describe "GET '/:project_token'" do
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

  describe "GET '/:project_token.md'" do
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

  describe "POST '/:project_token'" do
    context 'with invalid password' do
      before { request_to :post, "/#{project_token}", { password: 'dummy' } }
      it '' do
        expect(session[:admin]).to be_false
        expect(last_response).to be_redirect
      end
    end
    context 'with valid password' do
      before { request_to :post, "/#{project_token}", { password: project.password } }
      it '' do
        expect(session[:admin]).to be_true
        expect(last_response).to be_redirect
      end
    end
  end

  describe "PUT '/:project_token'" do
    pending
  end

  describe "POST '/:project_token/:kind'" do
    pending
  end

  describe "DELETE '/:project_token/:kind'" do
    pending
  end

end
