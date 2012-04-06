Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shibboleth, {
    extra_fields: [
      :"unscoped-affiliation",
      :entitlement,
      :affiliation,
      :"persistent-id"
    ]
  }
end