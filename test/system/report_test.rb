# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)
    @user = users(:alice)

    visit root_url
    fill_in 'Eメール', with: 'alice@test.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'creating a report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'test用のタイトルテキスト'
    fill_in '内容', with: 'test用のコンテンツテキスト'
    click_on '登録する'

    assert_text '日報が作成されました'
    assert_text 'test用のタイトルテキスト'
    assert_text 'test用のコンテンツテキスト'

    click_on '戻る'
  end

  test 'updating a report' do
    visit reports_url
    click_link('編集')

    fill_in 'タイトル', with: '編集後タイトル'
    fill_in '内容', with: '編集後メモ'
    click_on '更新する'

    assert_text '日報が更新されました'
    assert_text '編集後タイトル'
    assert_text '編集後メモ'
    click_on '戻る'
  end

  test 'destroying a report' do
    visit reports_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
    assert_no_text 'test用のタイトルテキスト'
    assert_no_text 'test用のコンテンツテキスト'
  end
end
