class HanabisController < ApplicationController
  before_action :user_signed_in?

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
      flash[:notice] = "花火スポットを登録しました"
      redirect_to hanabi_path(@hanabi)
    else
      render "new"
    end
  end

  def edit
    @hanabi = Hanabi.find(params[:id])
  end

  def update
    @hanabi = Hanabi.find(params[:id])
    @hanabi.update(hanabi_params)
    redirect_to @hanabi
  end

  def destroy
    @hanabi = Hanabi.find(params[:id])
    @hanabi.destroy
    flash[:success] = "削除しました"
    redirect_to :hanabis
  end

  private
  def hanabi_params
    params.require(:hanabi).permit(:title, :body, :address, :image)
  end
end
