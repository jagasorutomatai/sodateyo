require 'rails_helper'

RSpec.describe "Posts", type: :request do
  include RequestSupport
  let(:user) { create :user }
  before do
    log_in_as user
  end
  describe "GET /index" do
    it "returns http success" do
      get posts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_post_path
      expect(response).to have_http_status(:success)
    end
  end

end
