require 'test_helper'

class CreditcardsControllerTest < ActionController::TestCase
  setup do
    @creditcard = creditcards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:creditcards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create creditcard" do
    assert_difference('Creditcard.count') do
      post :create, creditcard: { annual_fee: @creditcard.annual_fee, business: @creditcard.business, chip: @creditcard.chip, country: @creditcard.country, fee_waived_first_year: @creditcard.fee_waived_first_year, first_purchase_bonus: @creditcard.first_purchase_bonus, foreign_transaction_fee: @creditcard.foreign_transaction_fee, image_index: @creditcard.image_index, issuer: @creditcard.issuer, name: @creditcard.name, notes: @creditcard.notes, personal: @creditcard.personal, points_per_dollar_spent_general_spend: @creditcard.points_per_dollar_spent_general_spend, points_program: @creditcard.points_program, second_year_spend_bonus: @creditcard.second_year_spend_bonus, second_year_spend_requirement: @creditcard.second_year_spend_requirement, second_year_time_to_reach_spend_in_months: @creditcard.second_year_time_to_reach_spend_in_months, spend_bonus: @creditcard.spend_bonus, spend_requirement: @creditcard.spend_requirement, time_to_reach_spend_in_months: @creditcard.time_to_reach_spend_in_months, url: @creditcard.url }
    end

    assert_redirected_to creditcard_path(assigns(:creditcard))
  end

  test "should show creditcard" do
    get :show, id: @creditcard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @creditcard
    assert_response :success
  end

  test "should update creditcard" do
    patch :update, id: @creditcard, creditcard: { annual_fee: @creditcard.annual_fee, business: @creditcard.business, chip: @creditcard.chip, country: @creditcard.country, fee_waived_first_year: @creditcard.fee_waived_first_year, first_purchase_bonus: @creditcard.first_purchase_bonus, foreign_transaction_fee: @creditcard.foreign_transaction_fee, image_index: @creditcard.image_index, issuer: @creditcard.issuer, name: @creditcard.name, notes: @creditcard.notes, personal: @creditcard.personal, points_per_dollar_spent_general_spend: @creditcard.points_per_dollar_spent_general_spend, points_program: @creditcard.points_program, second_year_spend_bonus: @creditcard.second_year_spend_bonus, second_year_spend_requirement: @creditcard.second_year_spend_requirement, second_year_time_to_reach_spend_in_months: @creditcard.second_year_time_to_reach_spend_in_months, spend_bonus: @creditcard.spend_bonus, spend_requirement: @creditcard.spend_requirement, time_to_reach_spend_in_months: @creditcard.time_to_reach_spend_in_months, url: @creditcard.url }
    assert_redirected_to creditcard_path(assigns(:creditcard))
  end

  test "should destroy creditcard" do
    assert_difference('Creditcard.count', -1) do
      delete :destroy, id: @creditcard
    end

    assert_redirected_to creditcards_path
  end
end
