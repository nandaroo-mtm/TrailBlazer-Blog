require 'rails_helper' 

RSpec.describe "Categories", type: :request do
  describe "GET /index" do
    before do
      get :index
    end

    it 'is expected to assign user instance variable' do
      expect(assigns[:model]).to eq(Categories.all)
    end
  end
end
