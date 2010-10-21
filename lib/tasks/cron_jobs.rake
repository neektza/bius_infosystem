namespace :cron do
  desc "Check if members are stil active."
  task :check_expiration => :environment do
    puts "Checking for expiration."
    Member.check_expiration()
  end
end
