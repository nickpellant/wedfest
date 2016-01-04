class AddBasketToBasketItems < ActiveRecord::Migration
  def change
    add_reference(
      :basket_items, :basket, index: true, foreign_key: true, null: false
    )
  end
end
