class Api::V1::ItemsController < Api::V1::BaseController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def purchase
    @item = Item.find(params[:id])
    if @item.stock > 0
      @item.stock -= 1
      @item.save
      current_user.items << @item
      render json: { message: "購入完了" }, status: 200
    else
      render json: {errors: "売り切れです。"}, status: 402
    end
  end
end
