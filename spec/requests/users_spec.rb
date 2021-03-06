require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let!(:hanabi) { create(:hanabi, user: user) }

  describe '新規登録画面' do
    before do
      get new_user_registration_path
    end

    it '正常なレスポンスを返すこと' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'ログイン画面' do
    let!(:user) { create(:user) }

    it '正常なレスポンスを返すこと' do
      get new_user_session_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'プロフィール画面' do
    context 'ログインしている場合' do
      before do
        sign_in user
        get user_path(user)
      end

      it 'レスポンスが成功すること' do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'プロフィール編集画面' do
    context 'ログインしている場合' do
      before do
        sign_in user
        get edit_user_registration_path(user.id)
      end

      it 'レスポンスが成功すること' do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context '花火が紐づくユーザーを削除した場合' do
      before do
        sign_in user
        get edit_user_registration_path(user.id)
      end

      it 'ユーザーと同時に紐づく花火も削除される' do
        user.hanabis.create(title: '花火スポットサンブル', body: 'サンプル')
        expect { user.destroy }.to change { Hanabi.count }.by(-1)
      end
    end
  end
end
