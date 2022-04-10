require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  it "レスポンスが正常に表示されること" do
    get user_path(user)
    expect(response).to have_http_status(200)
  end
end
