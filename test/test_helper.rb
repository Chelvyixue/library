ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
    !session[:admin_id].nil?
  end

  def log_in_as(admin, options = {})
    password = options[:password] || 'password'
    if integration_test?
      post login_path, session: { name: admin.name,
                                  password: password}
    else
      session[:user_id] = user.id
    end
  end

  def integration_test?
    defined?(post_via_redirect)
  end
end
