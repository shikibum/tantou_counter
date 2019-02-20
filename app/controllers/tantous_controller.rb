# frozen_string_literal: true

class TantousController < ApplicationController
  def index
    @tantous = current_user.tantous
    if current_user.tantous.last.present?
      last_tantou = current_user.tantous.last
      @tantou = Tantou.new(
        user: current_user,
        kinji_id: last_tantou.kinji_id,
        mokutan: last_tantou.mokutan,
        tamahagane: last_tantou.tamahagane,
        reikyakuzai: last_tantou.reikyakuzai,
        toishi: last_tantou.toishi,
        fuda: last_tantou.fuda
      )
    else
      @tantou = Tantou.new(user: current_user)
    end
  end

  def create
    @tantou = current_user.tantous.new(tantou_params)
    if @tantou.save!
      redirect_to tantous_path, notice: '鍛刀結果を保存しました'
    else
      render 'index'
    end
  end

  private

  def tantou_params
    params.require(:tantou).permit(
      :kinji_id,
      :mokutan,
      :tamahagane,
      :reikyakuzai,
      :toishi,
      :fuda,
      :katana_id
    )
  end
end
