Rails.application.config.middleware.use "Rack::Cors" do
  allow do
    origins "*"
    # We should be slightly more selective about which domains can request what.
    #
    # resource '/api/*', headers: :any, methods: %i(get post patch delete options)
    #
    # But for now we're going to be very permissive:
    resource '/api/*',
      headers: :any,
      methods: %i(get post patch put delete options),
      max_age: 600
  end
end
