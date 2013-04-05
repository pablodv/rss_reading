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

  describe "Avatar" do
    let(:user){ User.new }

    context "Paperclip behavior" do
      it "respond to avatar attachment" do
        user.should respond_to(:avatar)
      end

      it "have a paperclip filed named Avatar" do
        user.avatar.should be_an_instance_of(Paperclip::Attachment)
      end
    end

    context "validations" do
      it { should have_attached_file(:avatar) }
      it { should validate_attachment_presence(:avatar) }
      it { should validate_attachment_content_type(:avatar).
            allowing('image/png', 'image/jpeg').
            rejecting('text/plain', 'text/xml')
      }
    end
  end
end
