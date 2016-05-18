# MailxRuby

Simple Ruby wrapper for `mailx` command.

## Installation

```
require 'mailx_ruby'
```

## Usage

You need at least a body and receiver to send mail:

```
MailxRuby.send_mail body: "Hello world!", to: "joe@example.com"
```

Optional parameters exist for subject, CC, and BCC:

```
MailxRuby.send_mail(
  body: "Hello world!",
  subject: "Hello",
  to: "joe@example.com",
  cc: "cc@example.com",
  bcc: "bcc@example.com"
)
```

Option `:body` accepts multi-line strings.

Options `:to`, `:cc`, and `:bcc` accept strings or arrays of strings.
