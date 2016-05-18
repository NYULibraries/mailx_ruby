require 'spec_helper'
require 'mailx_ruby'

describe MailxRuby::CommandGenerator do
  
  describe "class methods" do
    describe "self.execute" do
      subject { described_class.execute options }
      let(:options){ {some: :options} }
      let(:generator){ double described_class, execute: true }
      before { allow(described_class).to receive(:new).and_return generator }

      it "should call execute on new instance" do
        expect(described_class).to receive(:new).with(options)
        expect(generator).to receive(:execute)
        subject
      end
    end
  end

  describe "instance methods" do
    let(:generator){ described_class.new options }
    let(:options){ ({body: "Hello world\nI'm here!", to: "jimbob@example.com"}) }

    describe "execute" do
      subject { generator.execute }
      let(:generated){ "mailx something" }
      before do
        allow(generator).to receive(:generate).and_return generated
        allow(generator).to receive(:`)
      end

      it "should execute string returned by generate" do
        expect(generator).to receive(:generate)
        expect(generator).to receive(:`).with(generated)
        subject
      end
    end

    describe "generate" do
      subject { generator.generate }
      let(:options_string){ nil }
      before { allow(generator).to receive(:options_string).and_return options_string }

      context "with string to" do
        context "without options_string" do
          it { is_expected.to eq "mailx  jimbob@example.com <<-EOM\nHello world\nI'm here!\nEOM" }
        end

        context "with options_string" do
          let(:options_string){ "-t JUSTTESTING" }

          it { is_expected.to eq "mailx -t JUSTTESTING jimbob@example.com <<-EOM\nHello world\nI'm here!\nEOM" }
        end
      end

      context "with array to" do
        let(:options){ ({body: "Hello world\nI'm here!", to: ["jimbob@example.com", "tinman@example.com"]}) }

        context "without options_string" do
          it { is_expected.to eq "mailx  jimbob@example.com,tinman@example.com <<-EOM\nHello world\nI'm here!\nEOM" }
        end

        context "with options_string" do
          let(:options_string){ "-t JUSTTESTING" }

          it { is_expected.to eq "mailx -t JUSTTESTING jimbob@example.com,tinman@example.com <<-EOM\nHello world\nI'm here!\nEOM" }
        end
      end
    end

    describe "options_string" do
      subject { generator.options_string }

      context "without subject" do
        context "without cc" do
          context 'without bcc' do
            it { is_expected.to be_empty }
          end

          context "with string bcc" do
            before { options[:bcc] = "jack@example.com" }

            it { is_expected.to eq '-b "jack@example.com"' }
          end

          context "with array bcc" do
            before { options[:bcc] = ["jack@example.com", "jill@example.com", "hill@example.com"] }

            it { is_expected.to eq '-b "jack@example.com,jill@example.com,hill@example.com"' }
          end
        end

        context "with string cc" do
          before { options[:cc] = "joebob@example.com" }

          context 'without bcc' do
            it { is_expected.to eq '-c "joebob@example.com"' }
          end

          context "with string bcc" do
            before { options[:bcc] = "jack@example.com" }

            it { is_expected.to eq '-c "joebob@example.com" -b "jack@example.com"' }
          end

          context "with array bcc" do
            before { options[:bcc] = ["jack@example.com", "jill@example.com", "hill@example.com"] }

            it { is_expected.to eq '-c "joebob@example.com" -b "jack@example.com,jill@example.com,hill@example.com"' }
          end
        end

        context "with array cc" do
          before { options[:cc] = ["joebob@example.com", "janebob@example.com"] }

          context 'without bcc' do
            it { is_expected.to eq '-c "joebob@example.com,janebob@example.com"' }
          end

          context "with string bcc" do
            before { options[:bcc] = "jack@example.com" }

            it { is_expected.to eq '-c "joebob@example.com,janebob@example.com" -b "jack@example.com"' }
          end

          context "with array bcc" do
            before { options[:bcc] = ["jack@example.com", "jill@example.com", "hill@example.com"] }

            it { is_expected.to eq '-c "joebob@example.com,janebob@example.com" -b "jack@example.com,jill@example.com,hill@example.com"' }
          end
        end
      end # end "without subject"

      context "with subject" do
        before { options[:subject] = "Hello there!" }

        context "without cc" do
          context 'without bcc' do
            it { is_expected.to eq '-s "Hello there!"' }
          end

          context "with string bcc" do
            before { options[:bcc] = "jack@example.com" }

            it { is_expected.to eq '-s "Hello there!" -b "jack@example.com"' }
          end

          context "with array bcc" do
            before { options[:bcc] = ["jack@example.com", "jill@example.com", "hill@example.com"] }

            it { is_expected.to eq '-s "Hello there!" -b "jack@example.com,jill@example.com,hill@example.com"' }
          end
        end

        context "with string cc" do
          before { options[:cc] = "joebob@example.com" }

          context 'without bcc' do
            it { is_expected.to eq '-s "Hello there!" -c "joebob@example.com"' }
          end

          context "with string bcc" do
            before { options[:bcc] = "jack@example.com" }

            it { is_expected.to eq '-s "Hello there!" -c "joebob@example.com" -b "jack@example.com"' }
          end

          context "with array bcc" do
            before { options[:bcc] = ["jack@example.com", "jill@example.com", "hill@example.com"] }

            it { is_expected.to eq '-s "Hello there!" -c "joebob@example.com" -b "jack@example.com,jill@example.com,hill@example.com"' }
          end
        end

        context "with array cc" do
          before { options[:cc] = ["joebob@example.com", "janebob@example.com"] }

          context 'without bcc' do
            it { is_expected.to eq '-s "Hello there!" -c "joebob@example.com,janebob@example.com"' }
          end

          context "with string bcc" do
            before { options[:bcc] = "jack@example.com" }

            it { is_expected.to eq '-s "Hello there!" -c "joebob@example.com,janebob@example.com" -b "jack@example.com"' }
          end

          context "with array bcc" do
            before { options[:bcc] = ["jack@example.com", "jill@example.com", "hill@example.com"] }

            it { is_expected.to eq '-s "Hello there!" -c "joebob@example.com,janebob@example.com" -b "jack@example.com,jill@example.com,hill@example.com"' }
          end
        end
      end # end "with subject"
    end
  end
end
