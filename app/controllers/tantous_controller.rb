# frozen_string_literal: true

class TantousController < ApplicationController
  before_action :require_current_user

  def index
    @tantous = current_user.tantous.order(created_at: :desc)
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

  def update
    @tantou = current_user.tantous.find(params[:id])
    if @tantou.update(tantou_params)
      redirect_to tantous_path
    else
      render 'index', notice: '結果を保存できませんでした'
    end
  end

  def create
    @tantou = current_user.tantous.new(tantou_params)
    if @tantou.save!
      redirect_to tantous_path
    else
      render 'index', notice: '鍛刀結果を保存できませんでした'
    end
  end

  def destroy
    @tantou = current_user.tantous.find(params[:id])
    if @tantou.destroy
      redirect_to tantous_path
    else
      render 'index', notice: '削除できませんでした'
    end
  end

  private

  def tantou_params
    if params[:tantou][:all].present?
      params.require(:tantou).permit(
        :kinji_id,
        :all,
        :fuda
      )
    elsif params[:tantou][:katana_id].present?
      params.require(:tantou).permit(
        :katana_id
      )
    else
      params.require(:tantou).permit(
        :kinji_id,
        :mokutan,
        :tamahagane,
        :reikyakuzai,
        :toishi,
        :fuda
      )
    end
  end
end
