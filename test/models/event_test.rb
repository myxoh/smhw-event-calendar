require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @beginning_of_week=Time.now.beginning_of_week
    @end_of_week=@beginning_of_week+7.days
    @event=Event.new(
        start: (@beginning_of_week+2.days).strftime("%Y-%m-%d"),
        finish: (@beginning_of_week+4.days).strftime("%Y-%m-%d"),
        title: "Something",
        description: "SomethingSomething"
    )
  end
  test "valid" do
    assert @event.valid?
  end

  def validator_test(param, event = @event)
    old_param = event[param]
    event[param] = ""
    assert_not event.valid?
    event[param] = old_param
  end

  test "Validators" do
    validator_test(:title)
    validator_test(:description)
    validator_test(:start)
    validator_test(:finish)
  end

  test "Method duration" do
    assert_equal 3, @event.duration #From 2 days to 4 days inclusive = 3 days.
  end

  def duration_days_test days, event
    assert_equal days, events(event).duration_days(@beginning_of_week)
  end

  def duration_days_equal_duration event, difference = 0
    duration_days_test(events(event).duration - difference, event)
  end

  def duration_days_past event
    duration_days_equal_duration event, (@beginning_of_week.to_date - events(event).start.to_date).to_i #Days from the beginning of the week
  end

  def duration_days_future event
    duration_days_equal_duration event, (
        events(event).finish.to_date - @end_of_week.to_date - #Days from the end of the week
        ((@beginning_of_week.to_date - events(event).start.to_date).to_i).to_i - 1
    ) #Days from the beginning of the week counting from 1

  end

  test "Method duration_this_week" do
    duration_days_test 0, :pastpast
    duration_days_past :pastpresent
    duration_days_test 7, :pastfuture
    duration_days_equal_duration :presentpresent
    duration_days_future :presentfuture
    duration_days_test 0, :futurefuture
  end

  test "Method beginingwday" do
    puts @beginning_of_week
    puts events(:presentpresent).start
    assert_equal 2, @event.beginning_wday(@beginning_of_week)
    assert_equal 0, events(:pastpast).beginning_wday(@beginning_of_week)
    assert_equal 0, events(:pastpresent).beginning_wday(@beginning_of_week)
    assert_equal 0, events(:pastfuture).beginning_wday(@beginning_of_week)
  end
end
