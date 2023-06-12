require 'rails_helper' 

RSpec.describe "Categories", type: :request do
  describe "GET /index" do
    before do
      get '/categories'
    end

    it 'is expected to assign category instance variable' do
      expect(assigns[:model]).to eq(Category.all)
    end
  end
end
