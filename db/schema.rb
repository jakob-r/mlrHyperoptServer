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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170425140053) do

  create_table "mlrhyper_parconfigs", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", comment: "mlrHyper Parameter Configurations" do |t|
    t.string   "user_email",          limit: 256,               null: false
    t.datetime "date",                                          null: false
    t.text     "json_parconfig",      limit: 65535,             null: false
    t.string   "json_parconfig_hash", limit: 32,                null: false
    t.text     "json_parvals",        limit: 65535,             null: false
    t.string   "json_parvals_hash",   limit: 32,                null: false
    t.string   "learner_class",       limit: 256,               null: false
    t.string   "learner_type",        limit: 32,                null: false
    t.string   "learner_name",        limit: 64,                null: false
    t.integer  "download_count",                    default: 0, null: false
    t.integer  "upload_count",                      default: 1, null: false
    t.index ["ID"], name: "ID", unique: true, using: :btree
    t.index ["json_parconfig_hash", "json_parvals_hash"], name: "json_parconfig_hash", unique: true, using: :btree
  end

  create_table "mlrhyper_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "email",   null: false
    t.string "passwd",  null: false
    t.string "api_key", null: false
  end

  create_table "parconfigs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "user_email",                   default: "<anonymous>"
    t.text     "json_parconfig", limit: 65535
    t.text     "json_parvals",   limit: 65535
    t.string   "learner_class"
    t.string   "learner_type"
    t.string   "learner_name"
    t.integer  "download_count",               default: 0
    t.integer  "upload_count",                 default: 0
    t.boolean  "default",                      default: false
    t.text     "note",           limit: 65535
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "par_hash",       limit: 32
    t.index ["par_hash"], name: "par_hash", unique: true, using: :btree
  end

  create_table "work_vlink", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", comment: "Für Vorlesungslinks" do |t|
    t.string   "punkt_kind",  limit: 10,                                         null: false
    t.string   "punkt_elter", limit: 10,                                         null: false
    t.string   "kind_type",   limit: 32,                                         null: false
    t.datetime "submit_time",               default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer  "ID",                                                             null: false
    t.string   "iphash",      limit: 32,                                         null: false
    t.integer  "ip_first",                                                       null: false
    t.text     "kind_notes",  limit: 65535,                                      null: false
    t.index ["ID"], name: "ID", using: :btree
  end

  create_table "wp_commentmeta", primary_key: "meta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint "comment_id",                    default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text   "meta_value", limit: 4294967295
    t.index ["comment_id"], name: "comment_id", using: :btree
    t.index ["meta_key"], name: "meta_key", using: :btree
  end

  create_table "wp_comments", primary_key: "comment_ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint   "comment_post_ID",                    default: 0,   null: false, unsigned: true
    t.text     "comment_author",       limit: 255,                 null: false
    t.string   "comment_author_email", limit: 100,   default: "",  null: false
    t.string   "comment_author_url",   limit: 200,   default: "",  null: false
    t.string   "comment_author_IP",    limit: 100,   default: "",  null: false
    t.datetime "comment_date",                                     null: false
    t.datetime "comment_date_gmt",                                 null: false
    t.text     "comment_content",      limit: 65535,               null: false
    t.integer  "comment_karma",                      default: 0,   null: false
    t.string   "comment_approved",     limit: 20,    default: "1", null: false
    t.string   "comment_agent",                      default: "",  null: false
    t.string   "comment_type",         limit: 20,    default: "",  null: false
    t.bigint   "comment_parent",                     default: 0,   null: false, unsigned: true
    t.bigint   "user_id",                            default: 0,   null: false, unsigned: true
    t.index ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt", using: :btree
    t.index ["comment_date_gmt"], name: "comment_date_gmt", using: :btree
    t.index ["comment_parent"], name: "comment_parent", using: :btree
    t.index ["comment_post_ID"], name: "comment_post_ID", using: :btree
  end

  create_table "wp_gallery_slides", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "title",       limit: 150,   default: "",     null: false
    t.text     "description", limit: 65535,                  null: false
    t.string   "image",       limit: 50,    default: "",     null: false
    t.string   "type",        limit: 4,     default: "file", null: false
    t.string   "image_url",   limit: 200,   default: "",     null: false
    t.string   "uselink",     limit: 1,     default: "N",    null: false
    t.string   "link",        limit: 200,   default: "",     null: false
    t.integer  "order",                     default: 0,      null: false
    t.datetime "created",                                    null: false
    t.datetime "modified",                                   null: false
  end

  create_table "wp_links", primary_key: "link_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "link_url",                          default: "",  null: false
    t.string   "link_name",                         default: "",  null: false
    t.string   "link_image",                        default: "",  null: false
    t.string   "link_target",      limit: 25,       default: "",  null: false
    t.string   "link_description",                  default: "",  null: false
    t.string   "link_visible",     limit: 20,       default: "Y", null: false
    t.bigint   "link_owner",                        default: 1,   null: false, unsigned: true
    t.integer  "link_rating",                       default: 0,   null: false
    t.datetime "link_updated",                                    null: false
    t.string   "link_rel",                          default: "",  null: false
    t.text     "link_notes",       limit: 16777215,               null: false
    t.string   "link_rss",                          default: "",  null: false
    t.index ["link_visible"], name: "link_visible", using: :btree
  end

  create_table "wp_options", primary_key: "option_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "option_name",  limit: 64,         default: "",    null: false
    t.text   "option_value", limit: 4294967295,                 null: false
    t.string "autoload",     limit: 20,         default: "yes", null: false
    t.index ["option_name"], name: "option_name", unique: true, using: :btree
  end

  create_table "wp_phpflickr_cache", primary_key: "request", id: :string, limit: 35, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.text     "response",   limit: 16777215, null: false
    t.datetime "expiration",                  null: false
  end

  create_table "wp_postmeta", primary_key: "meta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint "post_id",                       default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text   "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key", using: :btree
    t.index ["post_id"], name: "post_id", using: :btree
  end

  create_table "wp_posts", primary_key: "ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint   "post_author",                              default: 0,         null: false, unsigned: true
    t.datetime "post_date",                                                    null: false
    t.datetime "post_date_gmt",                                                null: false
    t.text     "post_content",          limit: 4294967295,                     null: false
    t.text     "post_title",            limit: 65535,                          null: false
    t.text     "post_excerpt",          limit: 65535,                          null: false
    t.string   "post_status",           limit: 20,         default: "publish", null: false
    t.string   "comment_status",        limit: 20,         default: "open",    null: false
    t.string   "ping_status",           limit: 20,         default: "open",    null: false
    t.string   "post_password",         limit: 20,         default: "",        null: false
    t.string   "post_name",             limit: 200,        default: "",        null: false
    t.text     "to_ping",               limit: 65535,                          null: false
    t.text     "pinged",                limit: 65535,                          null: false
    t.datetime "post_modified",                                                null: false
    t.datetime "post_modified_gmt",                                            null: false
    t.text     "post_content_filtered", limit: 4294967295,                     null: false
    t.bigint   "post_parent",                              default: 0,         null: false, unsigned: true
    t.string   "guid",                                     default: "",        null: false
    t.integer  "menu_order",                               default: 0,         null: false
    t.string   "post_type",             limit: 20,         default: "post",    null: false
    t.string   "post_mime_type",        limit: 100,        default: "",        null: false
    t.bigint   "comment_count",                            default: 0,         null: false
    t.index ["post_author"], name: "post_author", using: :btree
    t.index ["post_name"], name: "post_name", using: :btree
    t.index ["post_parent"], name: "post_parent", using: :btree
    t.index ["post_type", "post_status", "post_date", "ID"], name: "type_status_date", using: :btree
  end

  create_table "wp_term_relationships", primary_key: ["object_id", "term_taxonomy_id"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint  "object_id",        default: 0, null: false, unsigned: true
    t.bigint  "term_taxonomy_id", default: 0, null: false, unsigned: true
    t.integer "term_order",       default: 0, null: false
    t.index ["term_taxonomy_id"], name: "term_taxonomy_id", using: :btree
  end

  create_table "wp_term_taxonomy", primary_key: "term_taxonomy_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint "term_id",                        default: 0,  null: false, unsigned: true
    t.string "taxonomy",    limit: 32,         default: "", null: false
    t.text   "description", limit: 4294967295,              null: false
    t.bigint "parent",                         default: 0,  null: false, unsigned: true
    t.bigint "count",                          default: 0,  null: false
    t.index ["taxonomy"], name: "taxonomy", using: :btree
    t.index ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true, using: :btree
  end

  create_table "wp_terms", primary_key: "term_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name",       limit: 200, default: "", null: false
    t.string "slug",       limit: 200, default: "", null: false
    t.bigint "term_group",             default: 0,  null: false
    t.index ["name"], name: "name", using: :btree
    t.index ["slug"], name: "slug", unique: true, using: :btree
  end

  create_table "wp_usermeta", primary_key: "umeta_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id",                       default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text   "meta_value", limit: 4294967295
    t.index ["meta_key"], name: "meta_key", using: :btree
    t.index ["user_id"], name: "user_id", using: :btree
  end

  create_table "wp_users", primary_key: "ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "user_login",          limit: 60,  default: "", null: false
    t.string   "user_pass",           limit: 64,  default: "", null: false
    t.string   "user_nicename",       limit: 50,  default: "", null: false
    t.string   "user_email",          limit: 100, default: "", null: false
    t.string   "user_url",            limit: 100, default: "", null: false
    t.datetime "user_registered",                              null: false
    t.string   "user_activation_key", limit: 60,  default: "", null: false
    t.integer  "user_status",                     default: 0,  null: false
    t.string   "display_name",        limit: 250, default: "", null: false
    t.index ["user_login"], name: "user_login_key", using: :btree
    t.index ["user_nicename"], name: "user_nicename", using: :btree
  end

end
