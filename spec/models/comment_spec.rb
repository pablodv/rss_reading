require 'spec_helper'

describe Comment do
  describe "Validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :article_id }
    it { should validate_presence_of :body }
  end

  describe "Associations" do
    it{ should belong_to :user }
    it{ should belong_to :article }
  end
end
