# frozen_string_literal: true

require 'test_helper'

# This is user test
class UserTest < ActiveSupport::TestCase
  test 'user should not save without info' do
    user = User.new
    assert_not user.save
  end

  test 'user should not save without name' do
    user = User.new
    user.email = 'johndoe@example.com'
    assert_not user.save
  end

  test 'user should not save without email' do
    user = User.new
    user.name = 'John Doe'
    assert_not user.save
  end
end
