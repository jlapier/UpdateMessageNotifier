def ask question
  print question
  STDIN.gets.chomp
end

namespace :users do
  desc "Create a new user"
  task :create => [:environment] do
    user = User.new
    user.email = ask "Enter an email: "
    user.password = ask "Enter a password: "
    user.password_confirmation = ask "Confirm the password please: "
    admin = ask "Is admin? (Y/N): "
    user.is_admin = (admin.downcase == "y")
    if user.valid? and user.save
      puts "Saved new user: #{user.email}\n"
    else
      puts "User could not be saved: #{user.errors.full_messages.join('; ')}\n"
    end
  end

  desc "Make existing user admin"
  task :admin => [:environment] do
    email = ask "Enter email of existing user: "
    user = User.find_by_email(email)
    if user
      user.is_admin = true
      user.save
      puts "#{user.email} is now an admin."
    else
      puts "User not found."
    end
  end
end
