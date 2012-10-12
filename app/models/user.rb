# Stellt einen einzelnen Webseiten-Benutzer dar.
class User < ActiveRecord::Base
  # Erstellt einen neuen Benutzer aus von Omniauth übermittelten Daten.
  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth['uid']
      user.name = auth['info']['name']
    end
  end
end
