class ShopsController < ApplicationController
    def show
        @shop = Shop.find(params[:id])
        # ショップ詳細ページ(未定)
    end
end
