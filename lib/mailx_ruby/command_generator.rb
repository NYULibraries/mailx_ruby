module MailxRuby
  class CommandGenerator
    attr_accessor :body, :to, :subject, :cc, :bcc, :html

    def self.execute(options)
      new(options).execute
    end

    def initialize(attributes)
      assign_attributes attributes
    end

    def execute
      `#{generate}`
    end

    def body=(body_text)
      @body = Body.new(body_text)
    end

    def inline_css_body
      if !html
        body.text
      elsif body.has_css?
        body.to_inline_css
      else
        body.to_plain_text
      end
    end

    def generate
      "mailx #{options_string} #{stringify(to)} <<-\"EOM\"
#{inline_css_body}
EOM"
    end

    def options_string
      options_hash.map do |key, value|
        "-#{key} \"#{value}\""
      end.join(" ")
    end

    def subject_with_headers
      if html
        "$(echo \"#{subject}\nContent-Type: text/html\")"
      else
        subject
      end
    end

    private
    def self.symbolize_keys(hash)
      hash.map{|k,v| [k.to_sym, v] }.to_h
    end

    def assign_attributes(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

    def options_hash
      {
        s: subject_with_headers,
        c: stringify(cc),
        b: stringify(bcc),
      }.select{|k,v| v }
    end

    def stringify(arr_or_string)
      return nil unless arr_or_string
      arr_or_string.is_a?(Array) ? arr_or_string.join(",") : arr_or_string.to_s
    end
  end
end
