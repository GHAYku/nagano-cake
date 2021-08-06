class Public::CustomersController < ApplicationController
  def show
   @customer = current_customer
  end

  def edit
   @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "#{@customer.last_name + @customer.first_name}さんの会員情報を編集しました"
      redirect_to customers_path
    else
      render :edit
    end
  end

  def secession
  end

  def withdrawal
    customer = current_customer
    customer.update(is_active: false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
end

private

def customer_params
  params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :phone_number, :email,:is_active)
end
