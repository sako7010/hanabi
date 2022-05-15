require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  describe 'トップページ' do
    context 'ページ全体' do
      before do
        visit root_path
      end

      it '「きれいな花火　一緒に観よ」の文字が表示されていること' do
        expect(page).to have_content 'きれいな花火　一緒に観よ'
      end
    end
  end

  describe 'aboutページ' do
    before do
      visit about_path
    end

    it 'エンカシェアとは？の文字が表示されていること' do
      expect(page).to have_content 'エンカシェアとは？'
    end
  end

  describe '利用規約ページ' do
    before do
      visit terms_path
    end

    it '利用規約の文字が表示されていること' do
      expect(page).to have_content '利用規約'
    end
  end
end
