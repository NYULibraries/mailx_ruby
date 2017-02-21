# MailxRuby

[![NYU](https://github.com/NYULibraries/nyulibraries-assets/blob/master/lib/assets/images/nyu.png)](https://dev.library.nyu.edu)
[![Build Status](https://travis-ci.org/NYULibraries/mailx_ruby.svg)](https://travis-ci.org/NYULibraries/mailx_ruby)
[![Code Climate](https://codeclimate.com/github/NYULibraries/mailx_ruby/badges/gpa.svg)](https://codeclimate.com/github/NYULibraries/mailx_ruby)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/mailx_ruby/badge.svg?branch=master)](https://coveralls.io/github/NYULibraries/mailx_ruby?branch=master)

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
  bcc: ["bcc@example.com", "bcc.again@example.com"]
)
```

Options `:to`, `:cc`, and `:bcc` accept strings or arrays of strings.

Option `:body` accepts multi-line strings.

### HTML

You can specify `html: true`, and MailxRuby will attempt to send the body as HTML on supported OSs (including Mac OS X 10.11 and RHEL 6.5):

```
body = "<p>Hello world! Here's a list:
<ul>
  <li>Item 1</li>
  <li>Item 2</li>
</ul>"
MailxRuby.send_mail(body: body, to: "joe@example.com", html: true)
```

If the HTML body includes CSS styles, MailxRuby will automatically convert the CSS to email-supported inline styles using the [premailer gem](https://github.com/alexdunae/premailer).
