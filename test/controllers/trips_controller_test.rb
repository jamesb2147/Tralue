require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  setup do
    @trip = trips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip" do
    assert_difference('Trip.count') do
      post :create, trip: { aacostpts: @trip.aacostpts, aacostusd: @trip.aacostusd, abcostpts: @trip.abcostpts, abcostusd: @trip.abcostusd, accostpts: @trip.accostpts, accostusd: @trip.accostusd, afcostpts: @trip.afcostpts, afcostusd: @trip.afcostusd, amcostpts: @trip.amcostpts, amcostusd: @trip.amcostusd, ascostpts: @trip.ascostpts, ascostusd: @trip.ascostusd, azcostpts: @trip.azcostpts, azcostusd: @trip.azcostusd, bacostpts: @trip.bacostpts, bacostusd: @trip.bacostusd, brcostpts: @trip.brcostpts, brcostusd: @trip.brcostusd, cacostpts: @trip.cacostpts, cacostusd: @trip.cacostusd, costinusd: @trip.costinusd, cxcostpts: @trip.cxcostpts, cxcostusd: @trip.cxcostusd, czcostpts: @trip.czcostpts, czcostusd: @trip.czcostusd, dlcostpts: @trip.dlcostpts, dlcostusd: @trip.dlcostusd, ekcostpts: @trip.ekcostpts, ekcostusd: @trip.ekcostusd, eycostpts: @trip.eycostpts, eycostusd: @trip.eycostusd, g3costpts: @trip.g3costpts, g3costusd: @trip.g3costusd, gacostpts: @trip.gacostpts, gacostusd: @trip.gacostusd, hacostpts: @trip.hacostpts, hacostusd: @trip.hacostusd, hucostpts: @trip.hucostpts, hucostusd: @trip.hucostusd, ibcostpts: @trip.ibcostpts, ibcostusd: @trip.ibcostusd, integer: @trip.integer, jlcostpts: @trip.jlcostpts, jlcostusd: @trip.jlcostusd, lacostpts: @trip.lacostpts, lacostusd: @trip.lacostusd, lhcostpts: @trip.lhcostpts, lhcostusd: @trip.lhcostusd, lycostpts: @trip.lycostpts, lycostusd: @trip.lycostusd, mhcostpts: @trip.mhcostpts, mhcostusd: @trip.mhcostusd, mucostpts: @trip.mucostpts, mucostusd: @trip.mucostusd, name: @trip.name, nhcostpts: @trip.nhcostpts, nhcostusd: @trip.nhcostusd, nkcostpts: @trip.nkcostpts, nkcostusd: @trip.nkcostusd, nzcostpts: @trip.nzcostpts, nzcostusd: @trip.nzcostusd, ozcostpts: @trip.ozcostpts, ozcostusd: @trip.ozcostusd, qfcostpts: @trip.qfcostpts, qfcostusd: @trip.qfcostusd, qrcostpts: @trip.qrcostpts, qrcostusd: @trip.qrcostusd, sqcostpts: @trip.sqcostpts, sqcostusd: @trip.sqcostusd, svcostpts: @trip.svcostpts, svcostusd: @trip.svcostusd, tgcostpts: @trip.tgcostpts, tgcostusd: @trip.tgcostusd, uacostpts: @trip.uacostpts, uacostusd: @trip.uacostusd, user_id: @trip.user_id, vacostpts: @trip.vacostpts, vacostusd: @trip.vacostusd, vscostpts: @trip.vscostpts, vscostusd: @trip.vscostusd, vxcostpts: @trip.vxcostpts, vxcostusd: @trip.vxcostusd }
    end

    assert_redirected_to trip_path(assigns(:trip))
  end

  test "should show trip" do
    get :show, id: @trip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trip
    assert_response :success
  end

  test "should update trip" do
    patch :update, id: @trip, trip: { aacostpts: @trip.aacostpts, aacostusd: @trip.aacostusd, abcostpts: @trip.abcostpts, abcostusd: @trip.abcostusd, accostpts: @trip.accostpts, accostusd: @trip.accostusd, afcostpts: @trip.afcostpts, afcostusd: @trip.afcostusd, amcostpts: @trip.amcostpts, amcostusd: @trip.amcostusd, ascostpts: @trip.ascostpts, ascostusd: @trip.ascostusd, azcostpts: @trip.azcostpts, azcostusd: @trip.azcostusd, bacostpts: @trip.bacostpts, bacostusd: @trip.bacostusd, brcostpts: @trip.brcostpts, brcostusd: @trip.brcostusd, cacostpts: @trip.cacostpts, cacostusd: @trip.cacostusd, costinusd: @trip.costinusd, cxcostpts: @trip.cxcostpts, cxcostusd: @trip.cxcostusd, czcostpts: @trip.czcostpts, czcostusd: @trip.czcostusd, dlcostpts: @trip.dlcostpts, dlcostusd: @trip.dlcostusd, ekcostpts: @trip.ekcostpts, ekcostusd: @trip.ekcostusd, eycostpts: @trip.eycostpts, eycostusd: @trip.eycostusd, g3costpts: @trip.g3costpts, g3costusd: @trip.g3costusd, gacostpts: @trip.gacostpts, gacostusd: @trip.gacostusd, hacostpts: @trip.hacostpts, hacostusd: @trip.hacostusd, hucostpts: @trip.hucostpts, hucostusd: @trip.hucostusd, ibcostpts: @trip.ibcostpts, ibcostusd: @trip.ibcostusd, integer: @trip.integer, jlcostpts: @trip.jlcostpts, jlcostusd: @trip.jlcostusd, lacostpts: @trip.lacostpts, lacostusd: @trip.lacostusd, lhcostpts: @trip.lhcostpts, lhcostusd: @trip.lhcostusd, lycostpts: @trip.lycostpts, lycostusd: @trip.lycostusd, mhcostpts: @trip.mhcostpts, mhcostusd: @trip.mhcostusd, mucostpts: @trip.mucostpts, mucostusd: @trip.mucostusd, name: @trip.name, nhcostpts: @trip.nhcostpts, nhcostusd: @trip.nhcostusd, nkcostpts: @trip.nkcostpts, nkcostusd: @trip.nkcostusd, nzcostpts: @trip.nzcostpts, nzcostusd: @trip.nzcostusd, ozcostpts: @trip.ozcostpts, ozcostusd: @trip.ozcostusd, qfcostpts: @trip.qfcostpts, qfcostusd: @trip.qfcostusd, qrcostpts: @trip.qrcostpts, qrcostusd: @trip.qrcostusd, sqcostpts: @trip.sqcostpts, sqcostusd: @trip.sqcostusd, svcostpts: @trip.svcostpts, svcostusd: @trip.svcostusd, tgcostpts: @trip.tgcostpts, tgcostusd: @trip.tgcostusd, uacostpts: @trip.uacostpts, uacostusd: @trip.uacostusd, user_id: @trip.user_id, vacostpts: @trip.vacostpts, vacostusd: @trip.vacostusd, vscostpts: @trip.vscostpts, vscostusd: @trip.vscostusd, vxcostpts: @trip.vxcostpts, vxcostusd: @trip.vxcostusd }
    assert_redirected_to trip_path(assigns(:trip))
  end

  test "should destroy trip" do
    assert_difference('Trip.count', -1) do
      delete :destroy, id: @trip
    end

    assert_redirected_to trips_path
  end
end
