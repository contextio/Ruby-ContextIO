Context.IO 2.0 API Ruby Library
========
*  <a href="http://context.io/docs/" target="_blank">API documentation</a>
*  <a href="https://console.context.io/" target="_blank">API Explorer</a>
*  <a href="http://context.io" target="_blank">Sign Up</a>

## Description

This library is meant to serve as a way to connect to the 2.0 version of the Context.IO API. All classes contained in the library are name spaced under the `ContextIO` module and accept keyword arguments.

## Dependencies
* <a href="https://github.com/rspec/rspec" target="_blank">rspec</a>
* <a href="https://github.com/lostisland/faraday" target="_blank">Faraday</a>
* <a href="https://github.com/lostisland/faraday_middleware" target="_blank">Faraday Middleware</a>
* <a href="https://github.com/laserlemon/simple_oauth" target="_blank">Simple OAuth</a>

## Install

```ruby
gem install context_io
```

## Usage

First you need to instantiate a ContextIO class.

```ruby
cio = ContextIO::ContextIO.new(key: your_cio_key, secret: your_cio_secret)
```

Each class has it's own methods that are endpoints to the API. <a href="https://github.com/contextio/Ruby-ContextIO/blob/master/lib/context_io.rb#L38" target="_blank">ContextIO endpoints</a>.  From here you can fetch any accounts associated with your ContextIO Developer key.

```ruby
cio.get_accounts
```

This will return an array of all of the accounts. Each element of the array is an instantiated `Account` object with the data parsed from the API returned as instance variables.

```ruby
acc = cio.get_accounts[0].id => "this_account_id"
```

An object can be created as long as it is given a valid identifier and an instantiated parent. Every class, except for ContextIO, requires a `parent` and an `identifier` To make it easier on a user of this library you do not need to know what we call each identifier.

```ruby
message = ContextIO::Message.new(parent: acc, identifier: "some id")
```

A class instantiation will not call the API. In order to retrieve the data CIO has on an object you will need to call `get` on it.

```ruby
message.subject => nil
message = message.get
message.subject => "This message subject"
```

If an API call was not succesful, defined as not returning a status of 2XX, the library will throw a standard error with the message given in response.

```ruby
valid_length_id = "0" * 24
ContextIO::Account.new(parent: cio, identifier: "valid_length_id").get =>
StandardError: HTTP code 404. Response {"type"=>"error", "value"=>"account #{valid_length_id} is invalid"}
```

Some classes have methods that can only be called if it has the proper parent. For example a `Message` could have valid parents of `Account`, `Contact`, or `Folder`. If you attempt to call a method on a class without the proper parent you will receive a standard error.

```
account_message = ContextIO::Message.new(parent: account, identifier: "some id")
account_message.get_folders => <ContextIO::Message:0x007fabc ...

contact_message = ContextIO::Message.new(parent: contact, identifier: "some id")
contact_message.get_folders =>
StandardError: "This method can only be called from '2.0/accounts/:account/message/:message_id'"
```

## Example of an API call return

```ruby
=> #<ContextIO::Message:0x007fabc4dd9380
 @addresses={"from"=>{"email"=>"from_address", "name"=>"from_name"}, "to"=>[{"email"=>"to_email"}]},
 @api_call_made=
  #<struct ContextIO::APICallMade::CALL_MADE_STRUCT
   url=#<URI::HTTPS https://api.context.io/2.0/accounts/:account_id/messages>,
   method=:get,
   allowed_params=[],
   rejected_params=[]>,
 @connection=#<ContextIO::Connection:0x007fabc61e3998 @key=api_key, @secret=api_secret">,
 @date=Uniux timestamp,
 @date_indexed=Unix timestamp,
 @date_received=Unix timestamp,
 @email_message_id="<message_id>",
 @folders=["\\Important", "INBOX", "\\Inbox", "[Gmail]/Important"],
 @gmail_message_id="0000000000",
 @gmail_thread_id="0000000000",
 @message_id="00000000000000",
 @parent=
  #<ContextIO::Account:0x007fabc4ef2848
   @api_call_made=#<struct ContextIO::APICallMade::CALL_MADE_STRUCT url=#<URI::HTTPS https://api.context.io/2.0/accounts>, method=:get, allowed_params=[], rejected_params=[]>,
   @connection=#<ContextIO::Connection:0x007fabc61e3998 @key="key", @secret="secret">,
   @created=Unix timestamp,
   @email_addresses=["first_email_address", "second_email_address"],
   @first_name="Name",
   @id="0000000000000",
   @last_name="Name",
   @nb_messages=32,
   @parent=#<ContextIO::ContextIO:0x007fabc61e39e8 @call_url="/2.0", @connection=#<ContextIO::Connection:0x007fabc61e3998 @key="key", @secret="secret">>,
   @sources=
    [{"server"=>"server",
      "label"=>"label",
      "username"=>"username",
      "port"=>000,
      "use_ssl"=>true,
      "type"=>"imap",
      "authentication_type"=>"authentication_type",
      "status"=>"OK",
      "status_message"=>nil,
      "status_callback_url"=>nil,
      "resource_url"=>"https://api.context.io/2.0/accounts/:account_id/sources/:label",
      "sync_flags"=>false,
      "callback_url"=>nil,
      "sync_all_folders"=>false,
      "expunge_on_deleted_flag"=>false,
      "raw_file_list"=>false},
   @status=200,
   @success=true>,
 @resource_url="https://api.context.io/2.0/accounts/:account_id/messages/:message_id",
 @sources=[{"label"=>"source_label", "resource_url"=>"https://api.context.io/2.0/accounts/:account_id/sources/:label"}],
 @status=200,
 @subject="Email Subject",
 @success=true>

```

#### Two notes about API returns.
1. Each return will have an attached struct called `api_call_made`. This will contain the URL of the endpoint hit, the HTTP method, paramaters submitted with the call, and parameters rejected by the API.

2. The above listing shows the parent, and grand parent, of this object. Those are private attrs on each class and are not accessible outside of that class's code.

## Tests

There are unit tests for this library.  If you would like to submit a pull request against this project please ensure that you include the appropriate unit tests.

## Questions?

If you have any questions, don't hesitate to contact support@context.io
