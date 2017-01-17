require 'spec_helper'
require 'mailx_ruby'

describe MailxRuby::Body do
  let(:body){ described_class.new html }

  describe "has_css?" do
    subject{ body.has_css? }
    context "with plaintext" do
      let(:html){ "Some body" }

      it { is_expected.to be_falsy }
    end

    context "with HTML without CSS" do
      let(:html){ "<p>Hello World" }

      it { is_expected.to be_falsy }
    end

    context "with HTML with CSS" do
      let(:html) do
        "
        <html>
          <head>
            <style>
              p { color:red; }
            </style>
          </head>
          <body>
            <p>Some nonsense
          </body>
        </html>
        "
      end

      it { is_expected.to be_truthy }
    end
  end

  describe "premailer" do
    subject{ body.premailer }
    let(:html){ "<p>Hello World" }

    it { is_expected.to be_a Premailer }
  end
end
