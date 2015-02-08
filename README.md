# Email Parser

Email Parser is a simple Ruby client for parsing and interfacing with emails. Inspiration comes from [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) and [RFC 1341](https://www.ietf.org/rfc/rfc1341.txt) for dealing with emails with a content type of `multipart/alternative` which seems to be the most common for text based emails (those without images or videos).

## The Email Class

The public interface for parsing and interacting with an email is the `Email` class which accepts a raw email string upon initialization and provides two public facing methods for interacting with an email; `#header` and `#body`.

#### `#header`
Returns a header object that allows you to access all the header fields from the email in either dot `.` or bracket `[]` notation.

#### `#body`
Returns a body object that allows you to access the two most common body types of emails with a content type of `multiplart/alternative`. These are `text_plain` and `text_html`, which can also be accessed via dot `.` or bracket `[]` notation.

*Example*:

	email = Email.new( raw_email_string )

	email.header.from            => "Elon Musk <emusk@spacex.com>"
	email.header.to              => "Danny Garcia <dannygarcia.me@gmail.com>"
	email.header.subject         => "Let's blow things up!"
	email.header.date            => "05 Feb 2015 05:10:00 -0700"
	email.header.mime_version    => "1.0"
	email.header.content_type    => { value: 'multipart/alternative', params: {boundary: '123'} }

	email.body.text_plain        => "Hey let's hang out."
	email.body.text_html	     => "<div>Hey let's hang out</div>"


## Implementation (Summary)

The parsing of emails involves 3 different parsers that each have unique responsibilities.

### 1) EmailParser

According to RFC 2822, the header and body sections of an email are separated by an empty new line (CRLF). Given this knowledge, the `EmailParser` takes in a raw email string upon initialization and separates the header and body section of an email which will later be used by `HeaderParser` and `BodyParser` to parse the relevant data.

### 2) HeaderParser

According to RFC 2822, header fields begin with a field name, followed by a colon `:`, followed by a field body, and terminated with a newline. Given this knowledge, the `HeaderParser` takes in a raw header string upon initialization (supplied by the `EmailParser`) and parses the individual header fields; making them available via a header object (`#header`).

### 3) BodyParser

According to RFC 1341, each body part of an email message begins with an encapsulation boundary (which is supplied by the `content_type` header), followed by a header area, followed by an empty new line, followed by a body area, and terminated by the encapsulation boundary. Given this knowledge, the `BodyParser` takes in the `content_type` (supplied by the header) and a raw body string (supplied by the `EmailParser`) upon initialization.

Supplying the content type here is important because it specifies the type of email message to parse; `multipart/alternative`, `multipart/mixed`, etc. Each of these types contain different message structures, and therefore, need to be parsed differently. The `BodyParser`, upon initialization, is decorated with a parsing module that is specific to the content type of the message. I decided to take this approach because it allows for extensibility by easily allowing developers to create new parsing modules that are specific to different content types (MIME types). The `BodyParser` itself contains generic helper methods that are used by these decorator modules for parsing. As an example, see the `MultipartAlternativeParser` decorator which knows how to parse email messages with a content type of `multipart/alternative`.

## Tests

Tests are located in the `/spec` directory and can be run from the root directory by running `$ bundle exec rspec` from the command line. Specs written only test the public interface of the application, though integration specs do test that the entire application works as intended. My choice for only explicitly testing the public interface is twofold:

1) To assure the user that the application is adhering to the contract set by the public interface.

2) To ensure that we don't break the contract (public API) when changes are made.

## Example app

To see Email Parser in action, there is an example app that parses emails located in text files and displays them on an "email client". Here's how to get it running:

Within the email_parser directory:

1) Install dependencies: `$ bundle install`

2) `cd` into the `example_app` directory

3) Run the web server: `$ rackup`

4) Visit `localhost:9292` in your web browser.

## Next Steps

### Error Handling

In order to move towards a production grade email parser, I'd implement error handlers to account for any errors during parsing. This will prove essential when parsing emails that contain unknown file formats, image types, and attachments that are used by third party applications.

### MIME Type Decorators

Most emails these days contain different MIME types in the message body and/or as attachments. Next steps would be to implement decorators for the body parser that handle images and videos.