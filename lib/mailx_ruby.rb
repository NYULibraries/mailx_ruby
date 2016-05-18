module MailxRuby
  require 'mailx_ruby/command_generator'
  require 'mailx_ruby/version'

  def send_mail(body:, to:, **options)
    CommandGenerator.execute options.merge(body: body, to: to)
  end
  module_function :send_mail
end
