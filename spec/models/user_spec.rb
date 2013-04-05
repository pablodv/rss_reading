require 'spec_helper'

describe User do
  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:username) }
    it { should ensure_length_of(:first_name).is_at_most(50) }
    it { should ensure_length_of(:last_name).is_at_most(50) }
    it { should ensure_length_of(:username).is_at_most(50) }
  end
end
