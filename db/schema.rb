# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120127233015) do

  create_table "courses", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "abbreviation", :null => false
    t.integer  "term_id",      :null => false
    t.integer  "lecturer_id",  :null => false
    t.integer  "lock_version"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "courses", ["lecturer_id"], :name => "index_courses_on_lecturer_id"
  add_index "courses", ["term_id"], :name => "index_courses_on_term_id"

  create_table "dev_types", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "lock_version"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "dev_type_id",  :null => false
    t.integer  "lock_version"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "devices", ["dev_type_id"], :name => "index_devices_on_dev_type_id"

  create_table "doc_types", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "lock_version"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "description",    :null => false
    t.date     "course_date",    :null => false
    t.string   "file_extension"
    t.integer  "doc_type_id",    :null => false
    t.integer  "course_id",      :null => false
    t.integer  "lock_version"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "documents", ["course_id"], :name => "index_documents_on_course_id"
  add_index "documents", ["doc_type_id"], :name => "index_documents_on_doc_type_id"

  create_table "lecturers", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "lock_version"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "terms", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "lock_version"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_foreign_key "courses", "lecturers", :name => "courses_lecturer_id_fk"
  add_foreign_key "courses", "terms", :name => "courses_term_id_fk"

  add_foreign_key "devices", "dev_types", :name => "devices_dev_type_id_fk"

  add_foreign_key "documents", "courses", :name => "documents_course_id_fk"
  add_foreign_key "documents", "doc_types", :name => "documents_doc_type_id_fk"

end
