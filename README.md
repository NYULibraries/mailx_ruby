# MailxRuby

Simple Ruby wrapper for `mailx` command.

## Installation

```
gem 'mailx_ruby'
require 'mailx_ruby'
```

## Usage

You need at least a body and receiver to send mail:

```
MailxRuby.send_mail body: "Hello world!", to: "joe@example.com"
```

You can also specify subject, CC, and BCC:

```
MailxRuby.send_mail(
  body: "Hello world!",
  subject: "Hello",
  to: "joe@example.com",
  cc: "cc@example.com",
  bcc: "bcc@example.com"
)
```

Options `:to`, `:cc`, and `:bcc` accept strings or arrays of strings.

Option `:body` accepts multi-line strings. You can also specify `html: true`, and MailxRuby will attempt to send the body as HTML. This feature will not work on all OSs but it is tested to work on OS X and Jenkins.
