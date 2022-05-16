require 'rails_helper'

RSpec.describe Hanabi, type: :model do
  let(:hanabi) { create(:hanabi) }

  describe 'hanabiモデル' do
    context 'バリデーション' do
      it '有効な状態であること' do
        expect(hanabi).to be_valid
      end

      it 'タイトルがなければ無効な状態であること' do
        hanabi = build(:hanabi, title: nil)
        hanabi.valid?
        expect(hanabi.errors[:title]).to include('を入力してください')
      end

      it 'タイトルが30文字以内であること' do
        hanabi = build(:hanabi, title: 'あ' * 31)
        hanabi.valid?
        expect(hanabi.errors[:title]).to include('は30文字以内で入力してください')
      end

      it '住所が50文字以内であること' do
        hanabi = build(:hanabi, address: 'あ' * 51)
        hanabi.valid?
        expect(hanabi.errors[:address]).to include('は50文字以内で入力してください')
      end

      it '説明が140文字以内であること' do
        hanabi = build(:hanabi, body: 'あ' * 141)
        hanabi.valid?
        expect(hanabi.errors[:body]).to include('は140文字以内で入力してください')
      end
    end
  end
end
