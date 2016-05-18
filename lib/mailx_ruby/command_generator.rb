module MailxRuby
  class CommandGenerator
    attr_accessor :body, :to, :subject, :cc, :bcc

    def self.execute(options)
      new(options).execute
    end

    def initialize(attributes)
      assign_attributes attributes
    end

    def execute
      `#{generate}`
    end

    def generate
      "mailx #{options_string} #{stringify(to)} <<-EOM
#{body}
EOM"
    end

    def options_string
      options_hash.map do |key, value|
        "-#{key} \"#{value}\""
      end.join(" ")
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
        s: subject,
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
