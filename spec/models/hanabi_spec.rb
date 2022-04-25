require 'rails_helper'

RSpec.describe Hanabi, type: :model do
  let(:hanabi){ create(:hanabi) }

  describe "hanabiモデル" do
    context "バリデーション" do
      xit "一旦放置" do
        expect(page).to have_content 'きれいな花火　一緒に観よ'
      end
    end
  end
end
