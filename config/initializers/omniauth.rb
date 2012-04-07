Rails.application.config.middleware.use OmniAuth::Builder do
  # List of authentication services to be used.
  provider :shibboleth, {
    # Additional attributes provided by the Shibboleth IdP.
    extra_fields: [
      :"unscoped-affiliation",
      :entitlement,
      :affiliation,
      :"persistent-id"
    ]
  }
end