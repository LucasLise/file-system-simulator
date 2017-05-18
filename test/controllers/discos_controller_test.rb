require 'test_helper'

class DiscosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @disco = discos(:one)
  end

  test "should get index" do
    get discos_url
    assert_response :success
  end

  test "should get new" do
    get new_disco_url
    assert_response :success
  end

  test "should create disco" do
    assert_difference('Disco.count') do
      post discos_url, params: { disco: { dados: @disco.dados } }
    end

    assert_redirected_to disco_url(Disco.last)
  end

  test "should show disco" do
    get disco_url(@disco)
    assert_response :success
  end

  test "should get edit" do
    get edit_disco_url(@disco)
    assert_response :success
  end

  test "should update disco" do
    patch disco_url(@disco), params: { disco: { dados: @disco.dados } }
    assert_redirected_to disco_url(@disco)
  end

  test "should destroy disco" do
    assert_difference('Disco.count', -1) do
      delete disco_url(@disco)
    end

    assert_redirected_to discos_url
  end
end
