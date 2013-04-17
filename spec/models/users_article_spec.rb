require 'spec_helper'

describe UsersArticle do
  describe "Associations" do
    it { should belong_to :user }
    it { should belong_to :article }
  end

  describe "Validations" do
    describe "Mandatories" do
      it { should validate_presence_of :user_id }
      it { should validate_presence_of :article_id }
    end

    describe "Uniqueness" do
      it { should validate_uniqueness_of(:article_id).scoped_to(:user_id) }
    end
  end
end
