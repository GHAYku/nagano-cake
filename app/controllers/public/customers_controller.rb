class Public::CustomersController < ApplicationController
  def show
   @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "#{@customer.last_name + @customer.first_name}さんの会員情報を編集しました"
      redirect_to public_customer_path
    else
      render :edit
    end
  end

  def secession
  end

  def withdrawal
  end
end
