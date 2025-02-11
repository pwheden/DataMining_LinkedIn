require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get crew" do
    get :crew
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

end
