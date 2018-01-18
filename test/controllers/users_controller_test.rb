require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user  = users(:one)
    @user2 = {email: 'test2@example.com', subdomain: 'mytenant2', password: '123456'}
  end

  test "should not create user and multi-tenant database" do
    assert_no_difference(['User.count', 'Apartment.tenant_names.count']) do
      post user_registration_url, params: { user: { email: @user.email, subdomain: @user.subdomain } }
    end
  end

  test "should create user and multi-tenant database" do
    assert_difference(['User.count', 'Apartment.tenant_names.count']) do
      post user_registration_url, params: { user: @user2 }
    end

    assert_redirected_to users_dashboard_url(subdomain: @user2[:subdomain])
    assert_includes Apartment.tenant_names, @user2[:subdomain]
  end
end
