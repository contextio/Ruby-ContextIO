ERROR_STRING = "This method can only be called on a single account".freeze
require "contextio/utilities/request_helper"

class Account
  private
  attr_reader :connection

  public
  include RequestHelper
  attr_reader :response, :status, :success, :account_id
  def initialize(connection,
                 response,
                 status,
                 success,
                 account_id)
    @response = response
    @status = status
    @success =  success
    @connection = connection
    @account_id = account_id
  end

  def connect_tokens(token_id: nil, method: :get)
    if token_id
      craft_response(token_id, method, ConnectTokens, "connect_tokens")
    else
      craft_response(nil, method, ConnectTokens, "connect_tokens")
    end
  end

  def contacts(email: nil, method: :get)
    if email
      craft_response(email, method, Contacts, "contacts")
    else
      craft_response(nil, method, Contacts, "contacts")
    end
  end

  def email_addresses(email: nil, method: :get)
    if email
      craft_response(email, method, EmailAddresses, "email_addresses")
    else
      craft_response(nil, method, EmailAddresses, "email_addresses")
    end
  end

  def files(id: nil, method: :get)
    if id
      craft_response(id, method, Files, "files")
    else
      craft_response(id, method, Files, "files")
    end
  end

  def messages(id: nil, method: :get)
    craft_response(id, method, Messages, "messages")
  end

  def sources(id: nil, method: :get)
    craft_response(id, method, Sources, "sources")
  end

  def sync(method: :get)
    Sync.new(Request.new(connection, method, "/2.0/accounts/#{account_id}/sync"))
  end

  def threads(id: nil, method: :get)
    craft_response(id, method, Threads, "threads")
  end

  def webhooks(id: nil, method: :get)
    craft_response(id, method, Webhooks, "webhooks")
  end

  #TODO: Remove resource, add a hash e.g. { Webhooks: Webhooks }
  def craft_response(identifier, method, klass, resource)
    if account_id == nil
      #TODO: Throw an error
      FailedRequest.new(ERROR_STRING)
    elsif identifier
      klass.new(Request.new(connection,
                            method,
                            "/2.0/accounts/#{account_id}/#{klass.to_s.downcase}/#{identifier}"),
                  connection,
                  account_id,
                  identifier)
    else
      klass.new(CollectionRequest.new(connection,
                            method,
                            "/2.0/accounts/#{account_id}/#{resource}",
                            klass,
                            account_id),
                connection,
                account_id)
    end
  end

  def self.fetch(connection, id: nil, method: :get)
    if id
      Accounts.new(Request.new(connection, method, "/2.0/accounts/#{id}"),
                   connection,
                   id)
    else
      Accounts.new(CollectionRequest.new(connection, method, "/2.0/accounts", Accounts), connection)
    end
  end
end
