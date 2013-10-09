require 'test_helper'

class TeamsEmailsControllerTest < ActionController::TestCase
  setup do
    @teams_email = teams_emails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teams_email" do
    assert_difference('TeamsEmail.count') do
      post :create, teams_email: { email: @teams_email.email, kraj: @teams_email.kraj, naza: @teams_email.naza, osoba_kontaktowa: @teams_email.osoba_kontaktowa }
    end

    assert_redirected_to teams_email_path(assigns(:teams_email))
  end

  test "should show teams_email" do
    get :show, id: @teams_email
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teams_email
    assert_response :success
  end

  test "should update teams_email" do
    put :update, id: @teams_email, teams_email: { email: @teams_email.email, kraj: @teams_email.kraj, naza: @teams_email.naza, osoba_kontaktowa: @teams_email.osoba_kontaktowa }
    assert_redirected_to teams_email_path(assigns(:teams_email))
  end

  test "should destroy teams_email" do
    assert_difference('TeamsEmail.count', -1) do
      delete :destroy, id: @teams_email
    end

    assert_redirected_to teams_emails_path
  end
end
