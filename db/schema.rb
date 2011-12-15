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

ActiveRecord::Schema.define(:version => 20111214223732) do

  create_table "doc_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "description",  :null => false
    t.date     "lecture_date", :null => false
    t.integer  "doc_type_id",  :null => false
    t.integer  "lecture_id",   :null => false
    t.integer  "uploader_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["doc_type_id"], :name => "index_documents_on_doc_type_id"
  add_index "documents", ["lecture_id"], :name => "index_documents_on_lecture_id"
  add_index "documents", ["uploader_id"], :name => "index_documents_on_uploader_id"

  create_table "lecturers", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lectures", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "abbreviation", :null => false
    t.integer  "term_id",      :null => false
    t.integer  "lecturer_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lectures", ["lecturer_id"], :name => "index_lectures_on_lecturer_id"
  add_index "lectures", ["term_id"], :name => "index_lectures_on_term_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "terms", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
