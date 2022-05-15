require 'rails_helper'

RSpec.describe 'Hanabis', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:hanabi) { create(:hanabi, user: user) }

  describe 'GET /index' do
    before do
      sign_in user
      get hanabis_path(user)
    end

    context 'ログインしているユーザーの場合' do
      it 'レスポンスが正常に表示されること' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '花火詳細ページ' do
    context 'ログインしているユーザーの場合' do
      before do
        sign_in user
        get hanabi_path(hanabi.id)
      end

      it 'レスポンスが正常に表示されること' do
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていないユーザーの場合' do
      it 'ログイン画面にリダイレクトすること' do
        get hanabi_path(hanabi.id)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '花火スポット新規登録ページ' do
    context 'ログインしているユーザーの場合' do
      before do
        sign_in user
        get new_hanabi_path(user)
      end

      it 'レスポンスが正常に表示されること' do
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていないユーザーの場合' do
      it 'ログイン画面にリダイレクトすること' do
        get new_hanabi_path(user)
        expect(response.body).to include('ログインもしくはアカウント登録してください。')
      end
    end
  end

  describe '花火スポット編集ページ' do
    context 'ログインしているユーザーの場合' do
      before do
        sign_in user
        get edit_hanabi_path(hanabi.id)
      end

      it 'レスポンスが正常に表示されること' do
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていないユーザーの場合' do
      it 'ログイン画面にリダイレクトすること' do
        get new_hanabi_path(user)
        expect(response.body).to include('ログインもしくはアカウント登録してください。')
      end
    end

    context '別アカウントのユーザーの場合' do
      before do
        sign_in other_user
        get edit_hanabi_path(hanabi.id)
      end

      it '一覧画面にリダイレクトすること' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to hanabis_path
      end
    end
  end
end
