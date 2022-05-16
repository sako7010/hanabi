class HanabisController < ApplicationController
  before_action :user_signed_in?
  before_action :authenticate_user!
  before_action :correct_user, only: %i(edit update)

  def index
    @user = current_user
    @hanabis = Hanabi.all
  end

  def show
    @hanabi = Hanabi.find(params[:id])
  end

  def new
    @user = current_user
    @hanabi = Hanabi.new
  end

  def create
    @hanabi = Hanabi.new(hanabi_params)
    @hanabi.user_id = current_user.id
    if @hanabi.save
      flash[:notice] = '花火スポットを登録しました'
      redirect_to hanabi_path(@hanabi)
    else
      render 'new'
    end
  end

  def edit
    @hanabi = Hanabi.find(params[:id])
  end

  def update
    @hanabi = Hanabi.find(params[:id])
    if @hanabi.update(hanabi_params)
      flash[:notice] = '花火スポット情報を更新しました'
      redirect_to @hanabi
    else
      render 'edit'
    end
  end

  def destroy
    @hanabi = Hanabi.find(params[:id])
    @hanabi.destroy
    flash[:notice] = '削除しました'
    redirect_to :hanabis
  end

  private

  def hanabi_params
    params.require(:hanabi).permit(:title, :body, :address, :image)
  end

  def correct_user
    @hanabi = Hanabi.find(params[:id])
    @user = @hanabi.user
    redirect_to(hanabis_path) unless @user == current_user
  end
end
