require 'spec_helper'
require 'mailx_ruby'

describe MailxRuby do
  describe "VERSION" do
    subject { described_class::VERSION }
    it { is_expected.to_not be_nil }
  end
end
