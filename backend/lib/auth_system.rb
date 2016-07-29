module AuthSystem
  AccessDenied = Class.new(StandardError)

  def current_merchant
    api_token.try(:merchant)
  end

  def api_token_required
    api_token_authorized? || access_denied
  end

  def api_token_authorized?
    api_token.try(:merchant)
  end

  def api_token
    access_denied unless token_from_request
    @api_token ||= Token.where(value: token_from_request).first
  end

  def token_from_request
    @token_from_request ||=
      request.headers['x-jambo-api-token'].presence ||
      request.headers['x-api-token'].presence ||
      request.params['apiToken'].presence
  end

  def access_denied
    raise AccessDenied.new
  end

  def browser_call?
    request.headers['x-jambo-api-token'].present?
  end
end
