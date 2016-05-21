require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @beginning_of_week = Time.now.beginning_of_week
  end
  test "should get events on this week" do
    get :index
    assert_response :success
    week = assigns(:days)
    assert_equal 7, week.length
    assert_equal @beginning_of_week, week[0]
    events=Event.where("start < ?", @beginning_of_week + 7.days).where("finish > ?", @beginning_of_week)
    events.each do |e|
      assert_includes assigns(:events), e, "Missing Event"
    end
    assert_equal assigns(:events).length, Event.where("start < ?", @beginning_of_week + 7.days).where("finish > ?", @beginning_of_week).length
  end

  test "should create" do
    assert_difference('Event.count', 1) do
      post :create, event: {description: "Some desc", title: "Some title", start: Time.now, finish: Time.now}, week: @beginning_of_week
    end
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal Event.last.id, response["event"]["id"]
    assert_equal 1, response["status"]
  end

  test "should not create" do
    assert_difference('Event.count', 0) do
      post :create, event: {description: "Some desc", title: "", start: Time.now, finish: Time.now}, week: @beginning_of_week
    end
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal -1, response["status"]
    assert_not_nil response["errors"]
  end
end
