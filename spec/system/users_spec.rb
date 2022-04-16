require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "プロフィールページ" do
    let(:user) { create(:user) }

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

  describe "新規登録ページ" do
    before do
      visit new_user_registration_path
    end

    context "ページレイアウト" do
      it "「ユーザー新規登録」の文字列が存在すること" do
        expect(page).to have_content 'ユーザー新規登録'
      end
    end

    context "ユーザー登録処理" do
      it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
        fill_in "user[user_name]", with: "Example User"
        fill_in "user[email]", with: "user@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_button "登録"
        expect(page).to have_content "アカウント登録が完了しました。"
      end

      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "user[user_name]", with: ""
        fill_in "user[email]", with: "user@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "pass"
        click_button "登録"
        expect(page).to have_content "名前を入力してください"
        expect(page).to have_content "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it "「既に登録済みのかた」をクリックしたらログイン画面へ遷移すること" do
        click_link "既に登録済みのかた"
        expect(page).to have_current_path new_user_session_path
      end
    end
  end

  describe "ログインページ" do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    it "「ログイン」の文字列が存在すること" do
      expect(page).to have_content 'ログイン'
    end

    it "ヘッダーにログインページへのリンクがあること" do
      expect(page).to have_link 'ログイン', href: new_user_session_path
    end

    it "ログインフォームのラベルが正しく表示される" do
      expect(page).to have_content 'Eメール'
      expect(page).to have_content 'パスワード'
    end

    it "ログインフォームが正しく表示される" do
      expect(page).to have_css 'input#user_email'
      expect(page).to have_css 'input#user_password'
    end

    it "ログインボタンが表示される" do
      expect(page).to have_button 'ログイン'
    end

    it 'ログインに成功すること' do
      # ログインフォームに名前、Email及びパスワードを入力する
      fill_in 'user[user_name]', with: user.user_name
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      # ログインボタンをクリックする
      within ".actions" do
        click_button 'ログイン'
        # ログインに成功したことを検証する
        expect(current_path).to eq root_path(user)
      end
    end

    it 'ログインに失敗すること' do
      # ログインフォームに名前、Email及びパスワードを入力する
      fill_in 'user[user_name]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      # ログインボタンをクリックする
      within ".actions" do
        click_button 'ログイン'
        # ログインに成功したことを検証する
        expect(current_path).to eq new_user_session_path
      end
    end

    it "新規登録をクリックしたら新規登録画面へ遷移すること" do
      click_link "ユーザー登録"
      expect(page).to have_current_path new_user_registration_path
    end

    it "「パスワードを忘れた場合はこちら」をクリックしたらForgot your password?画面へ遷移すること" do
      click_link "パスワードを忘れた場合はこちら"
      expect(page).to have_current_path new_user_password_path
    end
  end
end
