require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'トップページ' do
    it '正常にレスポンスを返すこと' do
      get root_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'aboutページ' do
    it '正常にレスポンスを返すこと' do
      get about_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe '利用規約ページ' do
    it '正常にレスポンスを返すこと' do
      get terms_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
