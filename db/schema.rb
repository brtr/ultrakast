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

ActiveRecord::Schema.define(:version => 20140415055715) do

  create_table "alerts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "friend_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"
  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "categories_tutors", :force => true do |t|
    t.integer "tutor_id"
    t.integer "category_id"
  end

  add_index "categories_tutors", ["tutor_id", "category_id"], :name => "index_categories_tutors_on_tutor_id_and_category_id"

  create_table "categories_users", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "user_id"
  end

  add_index "categories_users", ["category_id"], :name => "index_categories_users_on_category_id"
  add_index "categories_users", ["user_id"], :name => "index_categories_users_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "start_time"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "status"
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "post_actions", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "content"
  end

  add_index "post_actions", ["post_id"], :name => "index_post_actions_on_post_id"
  add_index "post_actions", ["type"], :name => "index_post_actions_on_type"
  add_index "post_actions", ["user_id"], :name => "index_post_actions_on_user_id"

  create_table "posts", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "shared",             :default => false
    t.integer  "likes_count",        :default => 0
    t.integer  "favorites_count",    :default => 0
    t.integer  "comments_count",     :default => 0
    t.integer  "post_actions_count", :default => 0
    t.boolean  "rekast",             :default => false
    t.integer  "original_post"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"
  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"
  add_index "posts", ["updated_at"], :name => "index_posts_on_updated_at"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "read_statuses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "last_read_time"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "read_statuses", ["category_id"], :name => "index_read_statuses_on_category_id"
  add_index "read_statuses", ["user_id", "category_id"], :name => "index_read_statuses_on_user_id_and_category_id"
  add_index "read_statuses", ["user_id"], :name => "index_read_statuses_on_user_id"

  create_table "tutors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.integer  "posts_count",            :default => 0
    t.integer  "friends_count",          :default => 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "alerts_count",           :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
