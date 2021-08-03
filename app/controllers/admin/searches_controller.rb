class Admin::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @records_item = Item.search_for(@content)
    @record_customers = Customer.search_for(@content)
  end
end
