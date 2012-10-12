var search_data = {"index":{"searchIndex":["admin","coursescontroller","documentscontroller","applicationcontroller","campusonline","badrequest","notfound","unknownerror","course","coursescontroller","document","documentscontroller","homecontroller","sessioncontroller","user","utils","access_denied()","admin?()","cache_campusonline_data()","cached_attribute()","create()","create()","create()","create()","create_folder()","create_with_omniauth()","current_user()","dates()","delete_folder()","delete_uploaded_file()","destroy()","destroy()","destroy()","destroy()","edit()","edit()","edit()","fetch()","filename()","folder()","getcourse()","getcoursesoforganisation()","getcoursesofperson()","geteventsofcourse()","getstudentsofcourse()","id_is_a_valid_courseid()","index()","index()","index()","index()","index()","intro()","lecturers()","logged_in?()","name()","new()","new()","new()","redirect_if_not_admin()","redirect_if_not_logged_in()","sanitize_filename()","show()","show()","show()","show()","store_uploaded_file()","teaching_term()","update()","update()","update()","readme_for_app"],"longSearchIndex":["admin","admin::coursescontroller","admin::documentscontroller","applicationcontroller","campusonline","campusonline::badrequest","campusonline::notfound","campusonline::unknownerror","course","coursescontroller","document","documentscontroller","homecontroller","sessioncontroller","user","utils","homecontroller#access_denied()","applicationcontroller#admin?()","course#cache_campusonline_data()","course#cached_attribute()","admin::coursescontroller#create()","admin::documentscontroller#create()","documentscontroller#create()","sessioncontroller#create()","course#create_folder()","user::create_with_omniauth()","applicationcontroller#current_user()","course#dates()","course#delete_folder()","document#delete_uploaded_file()","admin::coursescontroller#destroy()","admin::documentscontroller#destroy()","documentscontroller#destroy()","sessioncontroller#destroy()","admin::coursescontroller#edit()","admin::documentscontroller#edit()","documentscontroller#edit()","campusonline::fetch()","document#filename()","course#folder()","campusonline::getcourse()","campusonline::getcoursesoforganisation()","campusonline::getcoursesofperson()","campusonline::geteventsofcourse()","campusonline::getstudentsofcourse()","course#id_is_a_valid_courseid()","admin::coursescontroller#index()","admin::documentscontroller#index()","coursescontroller#index()","documentscontroller#index()","homecontroller#index()","homecontroller#intro()","course#lecturers()","applicationcontroller#logged_in?()","course#name()","admin::coursescontroller#new()","admin::documentscontroller#new()","documentscontroller#new()","applicationcontroller#redirect_if_not_admin()","applicationcontroller#redirect_if_not_logged_in()","utils::sanitize_filename()","admin::coursescontroller#show()","admin::documentscontroller#show()","coursescontroller#show()","documentscontroller#show()","document#store_uploaded_file()","course#teaching_term()","admin::coursescontroller#update()","admin::documentscontroller#update()","documentscontroller#update()",""],"info":[["Admin","","Admin.html","",""],["Admin::CoursesController","","Admin/CoursesController.html","",""],["Admin::DocumentsController","","Admin/DocumentsController.html","",""],["ApplicationController","","ApplicationController.html","",""],["CAMPUSonline","","CAMPUSonline.html","","<p>Diese Klasse dient zum Zugriff auf CAMPUSonline-Systeme. CAMPUSonline\nstellt einen XML-Webservice zur …\n"],["CAMPUSonline::BadRequest","","CAMPUSonline/BadRequest.html","","<p>Wird benutzt, um einen Fehler “400” beim Aufruf des Web-Services\nanzuzeigen.\n<p>Wird normalerweise …\n"],["CAMPUSonline::NotFound","","CAMPUSonline/NotFound.html","","<p>Wird benutzt, um einen Fehler “404” beim Aufruf des Web-Services\nanzuzeigen.\n<p>Wird normalerweise …\n"],["CAMPUSonline::UnknownError","","CAMPUSonline/UnknownError.html","","<p>Wird benutzt, um einen unbekannten Fehler (alle außer “400” bzw. “404”)\nbeim Aufruf …\n"],["Course","","Course.html","","<p>Repräsentiert eine Veranstaltung aus TUMonline.\n<p>In der internen Datenbank werden lediglich zwei Werte …\n"],["CoursesController","","CoursesController.html","",""],["Document","","Document.html","",""],["DocumentsController","","DocumentsController.html","",""],["HomeController","","HomeController.html","",""],["SessionController","","SessionController.html","","<p>Verwaltet Sessions.\n"],["User","","User.html","","<p>Stellt einen einzelnen Webseiten-Benutzer dar.\n"],["Utils","","Utils.html","",""],["access_denied","HomeController","HomeController.html#method-i-access_denied","()",""],["admin?","ApplicationController","ApplicationController.html#method-i-admin-3F","()","<p>Gibt true zurück, wenn der aktuell angemeldete Benutzer ein Administrator\nist.\n"],["cache_campusonline_data","Course","Course.html#method-i-cache_campusonline_data","()","<p>Wird benutzt, um alle Informationen zur Veranstaltung auf einmal vom\nWebservice zu holen und zwischenzuspeichern, …\n"],["cached_attribute","Course","Course.html#method-i-cached_attribute","(key)","<p>Versucht, das Attribut “key” aus dem Cache zu holen bzw. erzwingt ein\nAktualisieren des Caches …\n"],["create","Admin::CoursesController","Admin/CoursesController.html#method-i-create","()","<p>POST /admin/courses\n"],["create","Admin::DocumentsController","Admin/DocumentsController.html#method-i-create","()","<p>POST /admin/documents\n"],["create","DocumentsController","DocumentsController.html#method-i-create","()","<p>POST /documents\n"],["create","SessionController","SessionController.html#method-i-create","()","<p>Erstellt bei der Anmeldung eine neue Session.\n"],["create_folder","Course","Course.html#method-i-create_folder","()","<p>Erstellt beim Erzeugen eines Datensatzes den dazugehörigen Ordner für die\nUploads.\n"],["create_with_omniauth","User","User.html#method-c-create_with_omniauth","(auth)","<p>Erstellt einen neuen Benutzer aus von Omniauth übermittelten Daten.\n"],["current_user","ApplicationController","ApplicationController.html#method-i-current_user","()","<p>Gibt den aktuellen angemeldeten Benutzer oder nil zurück\n"],["dates","Course","Course.html#method-i-dates","()","<p>Ein Array mit Daten, an denen die Veranstaltung stattfindet bzw.\nstattgefunden hat. Da diese Datumsangaben …\n"],["delete_folder","Course","Course.html#method-i-delete_folder","()","<p>Löscht beim Zerstören des Datensatzes den Ordner mit den hochgeladenen\nDateien.\n"],["delete_uploaded_file","Document","Document.html#method-i-delete_uploaded_file","()","<p>Löscht die Datei beim Zerstören des Datensatzes.\n"],["destroy","Admin::CoursesController","Admin/CoursesController.html#method-i-destroy","()","<p>DELETE /admin/courses/1\n"],["destroy","Admin::DocumentsController","Admin/DocumentsController.html#method-i-destroy","()","<p>DELETE /admin/documents/1\n"],["destroy","DocumentsController","DocumentsController.html#method-i-destroy","()","<p>DELETE /documents/1\n"],["destroy","SessionController","SessionController.html#method-i-destroy","()","<p>Zerstört die aktuelle Session bei der Abmeldung.\n"],["edit","Admin::CoursesController","Admin/CoursesController.html#method-i-edit","()","<p>GET /admin/courses/1/edit\n"],["edit","Admin::DocumentsController","Admin/DocumentsController.html#method-i-edit","()","<p>GET /admin/documents/1/edit\n"],["edit","DocumentsController","DocumentsController.html#method-i-edit","()","<p>GET /documents/1/edit\n"],["fetch","CAMPUSonline","CAMPUSonline.html#method-c-fetch","(url, params = {})","<p>Holt Daten vom Web Service.\n<p><strong>Parameter</strong>:\n<p><code>url</code> -&gt; die Teiladresse der zu holenden Daten\n"],["filename","Document","Document.html#method-i-filename","()","<p>Der vollständige Pfad der zum Dokument gehörigen Datei.\n"],["folder","Course","Course.html#method-i-folder","()","<p>Ermittelt den Pfad des Ordners, in dem alle Dateien gespeichert werden, die\nzu dieser Veranstaltung hochgeladen …\n"],["getCourse","CAMPUSonline","CAMPUSonline.html#method-c-getCourse","(courseID)","<p>Ermittelt Informationen zu einer Veranstaltung.\n<p><strong>Parameter</strong>:\n<p><code>courseID</code> -&gt; die ID der Veranstaltung\n"],["getCoursesOfOrganisation","CAMPUSonline","CAMPUSonline.html#method-c-getCoursesOfOrganisation","(orgUnitID)","<p>Ermittelt eine Liste aller Veranstaltungen einer Organisation.\n<p><strong>Parameter</strong>:\n<p><code>orgUnitID</code> -&gt; die ID der Organisation ...\n"],["getCoursesOfPerson","CAMPUSonline","CAMPUSonline.html#method-c-getCoursesOfPerson","(personID)","<p>Ermittelt eine Liste aller Veranstaltungen, die von einer Person angeboten\nwerden.\n<p><strong>Parameter</strong>:\n<p><code>personID</code> ...\n"],["getEventsOfCourse","CAMPUSonline","CAMPUSonline.html#method-c-getEventsOfCourse","(courseID)","<p>Ermittelt eine Liste aller Abhaltungstermine einer Veranstaltung.\n<p><strong>Parameter</strong>:\n<p><code>courseID</code> -&gt; die ID der ...\n"],["getStudentsOfCourse","CAMPUSonline","CAMPUSonline.html#method-c-getStudentsOfCourse","(courseID)","<p>Ermittelt eine Liste aller zu einer Veranstaltung angemeldeten Studenten.\n<p><strong>Parameter</strong>:\n<p><code>courseID</code> -&gt; die ...\n"],["id_is_a_valid_courseID","Course","Course.html#method-i-id_is_a_valid_courseID","()","<p>Prüft beim Anlegen eines Datensatzes, ob die übergebene ID auch vom\nCAMPUSonline-Webservice gefunden …\n"],["index","Admin::CoursesController","Admin/CoursesController.html#method-i-index","()","<p>GET /admin/courses\n"],["index","Admin::DocumentsController","Admin/DocumentsController.html#method-i-index","()","<p>GET /admin/documents\n"],["index","CoursesController","CoursesController.html#method-i-index","()","<p>GET /courses\n"],["index","DocumentsController","DocumentsController.html#method-i-index","()","<p>GET /documents\n"],["index","HomeController","HomeController.html#method-i-index","()",""],["intro","HomeController","HomeController.html#method-i-intro","()",""],["lecturers","Course","Course.html#method-i-lecturers","()","<p>Ein Array mit den Namen der Vortragenden.\n"],["logged_in?","ApplicationController","ApplicationController.html#method-i-logged_in-3F","()","<p>Gibt zurück, ob der Benutzer angemeldet ist.\n"],["name","Course","Course.html#method-i-name","()","<p>Der Name der Veranstaltung.\n"],["new","Admin::CoursesController","Admin/CoursesController.html#method-i-new","()","<p>GET /admin/courses/new\n"],["new","Admin::DocumentsController","Admin/DocumentsController.html#method-i-new","()","<p>GET /admin/documents/new\n"],["new","DocumentsController","DocumentsController.html#method-i-new","()","<p>GET /documents/new\n"],["redirect_if_not_admin","ApplicationController","ApplicationController.html#method-i-redirect_if_not_admin","()","<p>Leitet um, falls der Benutzer nicht angemeldet bzw. kein Administrator ist\nund eine geschützte Seite …\n"],["redirect_if_not_logged_in","ApplicationController","ApplicationController.html#method-i-redirect_if_not_logged_in","()","<p>Leitet um, falls der Benutzer nicht angemeldet ist und eine geschützte\nSeite öffnen möchte.\n"],["sanitize_filename","Utils","Utils.html#method-c-sanitize_filename","(filename)","<p>Erzeugt aus einem String einen gültigen Dateinamen. Dabei werden\nLeerzeichen am Anfang / Ende entfernt …\n"],["show","Admin::CoursesController","Admin/CoursesController.html#method-i-show","()","<p>GET /admin/courses/1\n"],["show","Admin::DocumentsController","Admin/DocumentsController.html#method-i-show","()","<p>GET /admin/documents/1\n"],["show","CoursesController","CoursesController.html#method-i-show","()","<p>GET /courses/1\n"],["show","DocumentsController","DocumentsController.html#method-i-show","()","<p>GET /documents/1\n"],["store_uploaded_file","Document","Document.html#method-i-store_uploaded_file","(file)","<p>Speichert die hochgeladene Datei ab. Wird direkt vom Controller aufgerufen.\n"],["teaching_term","Course","Course.html#method-i-teaching_term","()","<p>Das Semester, in dem die Veranstaltung stattfindet.\n"],["update","Admin::CoursesController","Admin/CoursesController.html#method-i-update","()","<p>PUT /admin/courses/1\n"],["update","Admin::DocumentsController","Admin/DocumentsController.html#method-i-update","()","<p>PUT /admin/documents/1\n"],["update","DocumentsController","DocumentsController.html#method-i-update","()","<p>PUT /documents/1\n"],["README_FOR_APP","","doc/README_FOR_APP.html","","<p>Use this README file to introduce your application and point to useful\nplaces in the API for learning …\n"]]}}