require "rubygems"
require 'test/unit'
gem "actionpack"
gem "actionmailer"
gem "activesupport"
require "active_support"
require "action_pack"
require "action_mailer"
require "init"

class Emailer < ActionMailer::Base
	def email(h)
		recipients   h[:recipients]
		subject      h[:subject]
		from         h[:from]
		body         h[:body]
		content_type "text/plain"
	end
end

class TlsTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def setup
    ActionMailer::Base.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :user_name => ENV['EMAIL'],
      :password => ENV['PASSWORD'],
      :authentication => :plain,
      :tls => true
    }
  end
  
  def test_send_mail
    Emailer.deliver_email(
      :recipients => ENV["EMAIL"],
      :subject => "SMTP/TLS test",
      :from => ENV["EMAIL"],
      :body => "This email was sent at #{Time.now.inspect}"
    )
  end
end
