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

ActiveRecord::Schema.define(:version => 20130903203522) do

  create_table "albums", :force => true do |t|
    t.string   "tytul"
    t.string   "przydzial"
    t.integer  "przydzial_id"
    t.date     "termin"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "dashboards", :force => true do |t|
    t.string   "tytul"
    t.text     "tekst"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "nazwa"
    t.text     "opis"
    t.integer  "nr_albumu"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "media", :force => true do |t|
    t.string   "url"
    t.string   "tytul"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    :default => false
    t.boolean  "recipient_deleted", :default => false
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "news", :force => true do |t|
    t.text     "tytul"
    t.text     "tekst_pl"
    t.text     "tekst_en"
    t.date     "termin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "redactor_assets", :force => true do |t|
    t.integer  "user_id"
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], :name => "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_redactor_assetable_type"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "tournaments", :force => true do |t|
    t.string   "nazwa"
    t.date     "termin_start"
    t.date     "termin_end"
    t.text     "opis_pl"
    t.text     "opis_en"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "name_surname"
    t.date     "born"
    t.string   "pesel"
    t.string   "role",               :default => "user"
    t.integer  "potwierdzenie",      :default => 0
    t.string   "avatar",             :default => "/avatar.jpg"
    t.integer  "login_count",        :default => 0,             :null => false
    t.integer  "failed_login_count", :default => 0,             :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

end
