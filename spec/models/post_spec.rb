require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "投稿" do
    before do
      @post = FactoryBot.build(:post)
    end

    context "投稿が保存できる" do
      it "必要な情報がある" do
        expect(@post).to be_valid
      end
      it "ハッシュタグがない" do 
        @post.tag_list = nil
        expect(@post).to be_valid
      end
    end

    context "投稿が保存できない" do
      it "タイトルがない" do
        @post.title = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Title can't be blank")
      end
      it "URLがない" do
        @post.url = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Url can't be blank")
      end
      it "画像がない" do
        @post.image = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
  
end
