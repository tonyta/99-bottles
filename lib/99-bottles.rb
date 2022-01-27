require "pry"

username = Pathname.pwd.join(".username").read.chomp
if username.empty?
  fail "add your name to the .username file"
end

user_dir = Pathname.pwd.join("lib", username)
unless user_dir.exist?
  user_dir.mkdir
  user_dir.join("bottles.rb").write <<~RUBY
    # #{username}'s implementation

    class Bottles
      # your code here
    end
  RUBY
end

$LOAD_PATH.unshift user_dir
require "bottles"
