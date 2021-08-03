class Public::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @records_item = Item.search_for(@content)
    #@record_customer = Customer.search_for(@content)
  end
end
