require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:one)
  end

  test "should get index" do
    get accounts_url, as: :json
    assert_response :success
  end

  test "should create account" do
    assert_difference("Account.count") do
      post accounts_url, params: { account: { account_number: @account.account_number, clients_id: @account.clients_id, current_value: @account.current_value, opening_date: @account.opening_date } }, as: :json
    end

    assert_response :created
  end

  test "should show account" do
    get account_url(@account), as: :json
    assert_response :success
  end

  test "should update account" do
    patch account_url(@account), params: { account: { account_number: @account.account_number, clients_id: @account.clients_id, current_value: @account.current_value, opening_date: @account.opening_date } }, as: :json
    assert_response :success
  end

  test "should destroy account" do
    assert_difference("Account.count", -1) do
      delete account_url(@account), as: :json
    end

    assert_response :no_content
  end
end
