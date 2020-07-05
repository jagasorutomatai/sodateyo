class SchemaSnapshot < ActiveRecord::Migration[5.2]
  def up
    create_table "calendars", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.text "content"
      t.integer "temperature", limit: 1
      t.bigint "post_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "picture"
      t.date "month"
      t.boolean "planted_flag", default: false
      t.boolean "harvested_flag", default: false
      t.index ["post_id"], name: "index_calendars_on_post_id"
    end
  
    create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.string "content"
      t.bigint "user_id"
      t.bigint "post_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["post_id"], name: "index_comments_on_post_id"
      t.index ["user_id"], name: "index_comments_on_user_id"
    end
  
    create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.bigint "post_id"
      t.bigint "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["post_id", "user_id"], name: "index_likes_on_post_id_and_user_id", unique: true
      t.index ["post_id"], name: "index_likes_on_post_id"
      t.index ["user_id"], name: "index_likes_on_user_id"
    end
  
    create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.string "title"
      t.text "content"
      t.bigint "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "picture"
      t.bigint "prefecture_id"
      t.date "planted_at"
      t.index ["prefecture_id"], name: "index_posts_on_prefecture_id"
      t.index ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"
      t.index ["user_id"], name: "index_posts_on_user_id"
    end
  
    create_table "prefectures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.integer "follower_id"
      t.integer "followed_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["followed_id"], name: "index_relationships_on_followed_id"
      t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
      t.index ["follower_id"], name: "index_relationships_on_follower_id"
    end
  
    create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
      t.string "name"
      t.string "email"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "password_digest"
      t.string "remember_digest"
      t.boolean "admin"
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  
    add_foreign_key "calendars", "posts"
    add_foreign_key "comments", "posts"
    add_foreign_key "comments", "users"
    add_foreign_key "likes", "posts"
    add_foreign_key "likes", "users"
    add_foreign_key "posts", "prefectures"
    add_foreign_key "posts", "users"
  end
end
