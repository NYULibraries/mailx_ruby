require 'spec_helper'
require 'mailx_ruby'

describe MailxRuby do
  describe "send_mail" do
    subject { described_class.send_mail **options }
    let(:commander){ described_class::CommandGenerator }
    before { allow(commander).to receive(:execute) }

    context "with body and to" do
      let(:options){ ({body: "body", to: "to"}) }

      it "should send them to CommandGenerator" do
        expect(commander).to receive(:execute).with(options)
        subject
      end

      context "with other options" do
        let(:options){ ({body: "body", to: "to", another: "thing", one: "more"}) }

        it "should send them to CommandGenerator" do
          expect(commander).to receive(:execute).with(options)
          subject
        end
      end
    end

    context "with only to" do
      let(:options){ ({to: "to"}) }

      it { expect{ subject }.to raise_error ArgumentError }
    end

    context "with only body" do
      let(:options){ ({body: "body"}) }

      it { expect{ subject }.to raise_error ArgumentError }
    end
  end
end
