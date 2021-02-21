module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    find('input[name="commit"]').click
  end

  # def login(admin_user)
  #   visit new_user_session_path
  #   fill_in 'メールアドレス', with: admin_user.email
  #   fill_in 'パスワード', with: admin_user.password
  #   find('input[name="commit"]').click
  # end
end
