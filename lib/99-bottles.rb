require "pry"

username_file = Pathname.pwd.join(".username")
unless username_file.exist?
  given_name = ""

  loop do
    print "Choose a username (one word): "
    given_name = STDIN.gets.chomp
    break if given_name.match?(/^\w+$/)
    print "#{given_name.inspect} isn't one word. "
  end

  puts "Creating a .username file to persist who you are..."
  username_file.write(given_name)
end

username = Pathname.pwd.join(".username").read.chomp
user_dir = Pathname.pwd.join("lib", username)
unless user_dir.exist?
  puts "Creating a directory for your code: #{user_dir.relative_path_from(Pathname.pwd)}"
  user_dir.mkdir
  user_dir.join("bottles.rb").write <<~RUBY
    # #{username}'s implementation

    class Bottles
      # your code here
    end
  RUBY

  puts "Press ENTER to continue..."
  STDIN.gets
end

$LOAD_PATH.unshift user_dir
require "bottles"
