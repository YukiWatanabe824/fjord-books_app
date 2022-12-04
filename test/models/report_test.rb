# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:alice)
    @user2 = users(:bob)
    @user1_report = reports(:one)
  end

  test '#editable?_test' do
    assert_not @user1_report.editable?(@user2)
    assert @user1_report.editable?(@user1)
  end

  test '#created_on' do
    my_report = Report.create!(title: 'sample', content: 'example', user: @user1, created_at: '2022-11-18 12:00:00')
    datetime = '2022-11-18 12:00:00'

    assert_equal datetime.to_date, my_report.created_on
  end
end
