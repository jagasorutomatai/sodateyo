require "csv"

# ユーザー(User)
CSV.foreach('db/fixtures/csv/users.csv', headers: true) do |row|
    User.create!(
      name: row['name'],
      email: row['email'],
      password: row['password'],
      password_confirmation: row['password_confirmation'],
      admin: row['admin']
    )
end

# 都道府県(Prefecture)
CSV.foreach('db/fixtures/csv/prefectures.csv', headers: true) do |row|
    Prefecture.create!(
      name: row['name']
    )
end

# 投稿(Post)
CSV.foreach('db/fixtures/csv/posts.csv', headers: true) do |row|
    Post.create!(
      title: row['title'],
      content: row['content'],
      picture: File.open(row['picture']),
      planted_at: row['planted_at'],
      user_id: row['user_id'],
      prefecture_id: row['prefecture_id']
    )
end

# カレンダー(Calendar)
CSV.foreach('db/fixtures/csv/calendars.csv', headers: true) do |row|
  Calendar.create!(
    month: row['month'],
    content: row['content'],
    temperature: row['temperature'],
    picture: File.open(row['picture']),
    planted_flag: row['planted_flag'],
    harvested_flag: row['harvested_flag'],
    post_id: row['post_id']
  )
end

# コメント(Comment)
CSV.foreach('db/fixtures/csv/comments.csv', headers: true) do |row|
  Comment.create!(
    content: row['content'],
    user_id: row['user_id'],
    post_id: row['post_id']
  )
end

# いいね(Like)
CSV.foreach('db/fixtures/csv/likes.csv', headers: true) do |row|
  Like.create!(
    post_id: row['post_id'],
    user_id: row['user_id']
  )
end

# フォロー(Relationship)
CSV.foreach('db/fixtures/csv/relationships.csv', headers: true) do |row|
  Relationship.create!(
    follower_id: row['follower_id'],
    followed_id: row['followed_id']
  )
end