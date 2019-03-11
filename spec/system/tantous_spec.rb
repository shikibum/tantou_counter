# frozen_string_literal: true

require 'rails_helper'

describe '鍛刀投稿機能' do
  before do
    create(:katana)
    create(:katana, :not_rare)
  end

  it 'can post tantou record' do
    visit tantous_path
    select('岩融', from: 'tantou[kinji_id]')
    fill_in 'tantou[mokutan]', with: 50
    fill_in 'tantou[tamahagane]', with: 50
    fill_in 'tantou[reikyakuzai]', with: 50
    fill_in 'tantou[toishi]', with: 50
    select('なし', from: 'tantou[fuda]')
    click_button '鍛刀'
    within '.tantou_result' do
      expect(page).to have_content '岩融'
      select('静形薙刀', from: 'tantou[katana_id]')
      click_button '入力'
      expect(page).to have_content '静形薙刀'
    end
  end

  it 'delete tantou record' do
    user = create(:user)
    create(:tantou, user: user)
    page.set_rack_session(user_id: user.id)
    visit tantous_path
    within '.tantou_result' do
      accept_alert do
        click_link '削除'
      end
    end
    expect(page).to have_no_css('.tantou_result')
  end

  it 'see only own record' do
    user = create(:user)
    create(:tantou, user: user)
    visit tantous_path
    expect(page).to have_no_css('.tantou_result')
  end

  it 'can visit show page' do
    user = create(:user)
    create(:tantou, user: user)
    page.set_rack_session(user_id: user.id)
    visit tantous_path
    click_link '集計結果をみる'
    expect(page).to have_css('.total')
  end
end
