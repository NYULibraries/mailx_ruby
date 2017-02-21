module MailxRuby
  class Body
    extend Forwardable
    delegate [:to_inline_css, :to_plain_text] => :premailer

    attr_accessor :html
    alias_method :text, :html

    def initialize(html)
      @html = html
    end

    def has_css?
      nokogiri_html.xpath("//style").any?
    end

    def premailer
      @premailer ||= generate_premailer
    end

    private

    def nokogiri_html
      @nokogiri_html ||= Nokogiri::HTML(html)
    end

    def generate_premailer
      File.open(tmp_filepath, "w"){|f| f.write(html) }
      premailer = Premailer.new(tmp_filepath, warn_level: Premailer::Warnings::SAFE)
      File.delete(tmp_filepath)
      premailer
    end

    def tmp_filepath
      @tmp_filepath ||= "mail#{Time.now.to_i}.html"
    end
  end
end
