require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
describe "新規登録" do
  context "新規登録がうまくいく時" do
    it "ニックネーム、email、passwordが全て埋まっている" do
      expect(@user).to be_valid 
    end
  end
  context "新規登録が情報が埋まってなくて登録できない" do
    it "ネームが空" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank") 
    end
    it "メールアドレスが空" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank") 
    end
    it "パスワードが空" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank") 
    end
    
  end
  context "別途設定したvalidatesで登録できない場合" do
    it "同じemailでの登録" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "同じニックネームでの登録" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.name = @user.name
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Name has already been taken")
    end
    it "passwordが6文字以下" do
      @user.password = "abc1"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "passwordに半角数字が混ざっていない" do
      @user.password = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password 半角英数字を含む6文字以上のパスワードにしてください")
    end

  end
end
end
