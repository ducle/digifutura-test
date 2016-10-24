require 'rails_helper'

RSpec.describe NodesController, type: :controller do
  login_user

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    let(:folder) { FactoryGirl.create(:file_node, owner: subject.current_user)}
    it "returns http success" do
      get :show, params: { id: folder.id }
      expect(response).to have_http_status(:success)
    end
  end

end
