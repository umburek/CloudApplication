class QuotesController < ApplicationController
  before_action :authenticate_user!

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)
    @quote.user = current_user

    if @quote.save
      redirect_to new_quote_path
    else
      render :new
    end
  end

  def destroy
    Quote.find_by(id: params[:id]).destroy
    redirect_to new_quote_path, :notice => "Your quote has been deleted"
  end

  private

  def quote_params
    params.require(:quote).permit(:label)
  end
end
