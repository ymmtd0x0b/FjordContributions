# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    allow(Newspaper).to receive(:publish).with(:user_update, kind_of(Hash))
    allow(Newspaper).to receive(:publish).with(:user_destroy, kind_of(User))
  end

  scenario 'ユーザー情報を更新する', vcr: { cassette_name: 'system/user_update' } do
    create(:repository, id: 123, name: 'test/repository')
    kimura = create(:user, id: 456, login: 'kimura', name: 'きむら', avatar_url: 'https://example.com/before_avatar.png')

    login_as kimura
    expect(page).to have_button 'きむら'
    expect(page).to have_selector 'img[src$="https://example.com/before_avatar.png"]'

    click_button '最新情報へ更新'
    click_button 'はい'

    expect(page).to have_content '更新に成功しました'
    expect(page).to have_button 'キムラ'
    expect(page).to have_selector 'img[src$="https://example.com/after_avatar.png"]'
    expect(Newspaper).to have_received(:publish).with(:user_update, kind_of(Hash))
  end

  context '更新に失敗した場合' do
    scenario '失敗したことを Flash メッセージ で通知する', vcr: { cassette_name: 'system/user_update_with_failed' } do
      create(:repository, id: 123, name: 'test/repository')
      kimura = create(:user, id: 456, login: 'kimura')

      login_as kimura, to: current_user_wikis_path
      expect(page).to have_current_path current_user_wikis_path

      click_button '最新情報へ更新'
      click_button 'はい'

      expect(page).to have_content '更新に失敗しました'
      expect(page).to have_current_path current_user_wikis_path
    end
  end

  scenario 'ユーザーを削除する' do
    create(:repository, id: 123, name: 'test/repository')
    kimura = create(:user, login: 'kimura')

    login_as kimura
    click_button 'toast-close'

    expect do
      click_button 'kimura'
      click_button 'アカウント削除'
      click_button 'はい'

      expect(page).to have_content 'アカウントを削除しました'
    end.to change(User, :count).by(-1)

    expect(Newspaper).to have_received(:publish).with(:user_destroy, kind_of(User))
  end

  context '削除に失敗した場合' do
    scenario '失敗したことを Flash メッセージ で通知する' do
      allow(Newspaper).to receive(:publish).and_raise(ActiveRecord::RecordNotDestroyed)

      create(:repository, id: 123, name: 'test/repository')
      kimura = create(:user, id: 456, login: 'kimura')

      login_as kimura, to: current_user_wikis_path
      expect(page).to have_current_path current_user_wikis_path

      expect do
        click_button 'kimura'
        click_button 'アカウント削除'
        click_button 'はい'

        expect(page).to have_content '削除に失敗しました'
        expect(page).to have_current_path current_user_wikis_path
      end.not_to change(User, :count)
    end
  end
end
