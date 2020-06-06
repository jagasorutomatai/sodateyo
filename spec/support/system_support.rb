module SystemSupport
  def log_in_as(user)
    visit login_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: 'password'
    click_on 'ログインする'
  end
end
