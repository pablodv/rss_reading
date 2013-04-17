require 'spec_helper'

describe Article do
  describe "Associations" do
    it { should belong_to :channel }
  end

  describe "Validations" do
    describe "Mandatories" do
      it { should validate_presence_of :title }
      it { should validate_presence_of :link }
      it { should validate_presence_of :description }
      it { should validate_presence_of :published_at }
      it { should validate_presence_of :channel }
    end

    describe "Uniqness" do
      it { should validate_uniqueness_of(:title).scoped_to(:channel_id) }
    end
  end
end
