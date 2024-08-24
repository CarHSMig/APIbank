require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get clients_url, as: :json
    assert_response :success
  end

  test "should create client" do
    assert_difference("Client.count") do
      post clients_url, params: { client: { birth_date: @client.birth_date, doc_number: @client.doc_number, doc_type: @client.doc_type, name: @client.name, password: @client.password, string: @client.string } }, as: :json
    end

    assert_response :created
  end

  test "should show client" do
    get client_url(@client), as: :json
    assert_response :success
  end

  test "should update client" do
    patch client_url(@client), params: { client: { birth_date: @client.birth_date, doc_number: @client.doc_number, doc_type: @client.doc_type, name: @client.name, password: @client.password, string: @client.string } }, as: :json
    assert_response :success
  end

  test "should destroy client" do
    assert_difference("Client.count", -1) do
      delete client_url(@client), as: :json
    end

    assert_response :no_content
  end
end
