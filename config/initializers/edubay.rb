# coding: utf-8

# Lädt beim Start des Servers Einstellungen aus "config/edubay.yml"
values = YAML.load_file("#{Rails.root}/config/edubay.yml")[::Rails.env]

Edubay::Application.config.campusonline_token = values['campusonline_token']
Edubay::Application.config.cache_expiration = values['cache_expiration']

# Lädt die Benutzerkennungen der Administratoren und friert das Array ein,
# um Veränderungen zur Laufzeit zu verhindern
Edubay::Application.config.admin_ids = values['admin_ids']
Edubay::Application.config.admin_ids.freeze()
