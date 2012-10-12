Rails.application.config.middleware.use OmniAuth::Builder do
  # List der erlaubten Authentifizierungsservices
  provider :shibboleth, {
    # Zusätzliche Attribute, die vom Shibboleth Identity Provider übermittelt werden
    extra_fields: [
      :"unscoped-affiliation",
      :entitlement,
      :affiliation,
      :"persistent-id"
    ]
  }
end