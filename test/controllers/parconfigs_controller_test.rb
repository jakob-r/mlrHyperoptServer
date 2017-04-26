require 'test_helper'

class ParconfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parconfig = parconfigs(:one)
  end

  test "should get index" do
    get parconfigs_url
    assert_response :success
  end

  test "should get new" do
    get new_parconfig_url
    assert_response :success
  end

  test "should create parconfig" do
    assert_difference('Parconfig.count') do
      post parconfigs_url, params: { parconfig: { date: @parconfig.date, default: @parconfig.default, download_count: @parconfig.download_count, json_parconfig: @parconfig.json_parconfig, json_parvals: @parconfig.json_parvals, learner_class: @parconfig.learner_class, learner_name: @parconfig.learner_name, learner_type: @parconfig.learner_type, upload_count: @parconfig.upload_count, user_email: @parconfig.user_email } }
    end

    assert_redirected_to parconfig_url(Parconfig.last)
  end

  test "should show parconfig" do
    get parconfig_url(@parconfig)
    assert_response :success
  end

  test "should get edit" do
    get edit_parconfig_url(@parconfig)
    assert_response :success
  end

  test "should update parconfig" do
    patch parconfig_url(@parconfig), params: { parconfig: { date: @parconfig.date, default: @parconfig.default, download_count: @parconfig.download_count, json_parconfig: @parconfig.json_parconfig, json_parvals: @parconfig.json_parvals, learner_class: @parconfig.learner_class, learner_name: @parconfig.learner_name, learner_type: @parconfig.learner_type, upload_count: @parconfig.upload_count, user_email: @parconfig.user_email } }
    assert_redirected_to parconfig_url(@parconfig)
  end

  test "should destroy parconfig" do
    assert_difference('Parconfig.count', -1) do
      delete parconfig_url(@parconfig)
    end

    assert_redirected_to parconfigs_url
  end
end
