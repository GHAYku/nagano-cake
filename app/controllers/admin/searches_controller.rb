class Admin::SearchesController < ApplicationController
before_action :authenticate_admin!
  def search
    @content = params[:content]
    @records_item = Item.search_for(@content)
    @record_customers = Customer.search_for(@content)
  end
end
