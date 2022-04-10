require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        visit user_path(user.id)
      end

      it "「プロフィール」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール'
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.user_name
        expect(page).to have_content user.profile
      end
    end
  end
end
