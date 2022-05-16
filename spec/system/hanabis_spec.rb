require 'rails_helper'

RSpec.describe 'Hanabis', type: :system do
  let(:user) { create(:user) }
  let(:hanabi) { create(:hanabi, user: user) }

  xdescribe 'GET /index' do
    before do
      sign_in user
      get hanabis_path(user)
    end

    xcontext 'ログインしているユーザーの場合' do
      it 'レスポンスが正常に表示されること' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '花火スポット詳細ページ' do
    before do
      sign_in user
      visit hanabi_path(hanabi.id)
    end

    it '花火スポット情報が表示されること' do
      expect(page).to have_content hanabi.title
      expect(page).to have_content hanabi.address
      expect(page).to have_content hanabi.body
    end

    context '削除する' do
      it '花火スポット消去' do
        click_button '削除'
        expect(page).to have_content '削除しました'
      end
    end
  end

  describe '花火スポット登録ページ' do
    before do
      sign_in user
      visit new_hanabi_path(user)
    end

    it '「花火スポット登録」の文字列が存在すること' do
      expect(page).to have_content '花火スポット登録'
    end

    it '入力部分に適切なラベルが表示されること' do
      expect(page).to have_content 'タイトル'
      expect(page).to have_content '住所'
      expect(page).to have_content '説明'
    end

    context '花火スポット登録処理' do
      it '有効な情報で花火スポット登録を行うと花火スポット登録成功のフラッシュが表示されること' do
        fill_in 'hanabi_title', with: 'Example Hanabi'
        fill_in 'address', with: 'Example address'
        fill_in 'explanation', with: 'Example explanation'
        click_button '登録する'
        expect(page).to have_content '花火スポットを登録しました'
      end

      it '無効な情報で花火スポット登録を行うと花火スポット登録失敗のフラッシュが表示されること' do
        fill_in 'hanabi_title', with: ''
        fill_in 'address', with: ''
        fill_in 'explanation', with: ''
        click_button '登録'
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content '住所を入力してください'
        expect(page).to have_content '説明を入力してください'
      end
    end
  end

  describe 'GET /edit' do
    before do
      sign_in user
      visit edit_hanabi_path(hanabi.id)
    end

    it '入力部分に適切なラベルが表示されること' do
      expect(page).to have_content 'タイトル'
      expect(page).to have_content '住所'
      expect(page).to have_content '説明'
    end

    context '花火スポット登録処理' do
      it '有効な更新を行うこと' do
        fill_in 'hanabi_title', with: 'Example Hanabi edit'
        fill_in 'address', with: 'Example address edit'
        fill_in 'explanation', with: 'Example explanation edit'
        click_button '更新する'
        expect(page).to have_content '花火スポット情報を更新しました'
      end

      it '無効な情報で花火スポット登録を行うと花火スポット登録失敗のフラッシュが表示されること' do
        fill_in 'hanabi_title', with: ''
        fill_in 'address', with: ''
        fill_in 'explanation', with: ''
        click_button '更新する'
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content '住所を入力してください'
        expect(page).to have_content '説明を入力してください'
      end
    end
  end
end
