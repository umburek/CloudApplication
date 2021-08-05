class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :count_visits, only: :create

  def new
    return redirect_to root_path if Quote.count < 2

    quote_1 = current_user.quotes.order('RANDOM()').first
    quote_2 = current_user.quotes.where.not(id: quote_1.id).order('RANDOM()').first

    @visits = (cookies[:visits] || 0).to_i
    if @visits = (cookies[:visits] || 0).to_i >= 4
      redirect_to new_quote_url
    else @visits = (cookies[:visits] || 0).to_i
    end

    @quotes = current_user.quotes.order(:score).limit(10)

    @vote_form_left = VoteForm.new(preferred_quote_id: quote_1.id, other_quote_id: quote_2.id)
    @vote_form_right = VoteForm.new(preferred_quote_id: quote_2.id, other_quote_id: quote_1.id)
  end

  def create
    VoteForm.new(params[:vote]).save

    redirect_to new_vote_path
  end

  def count_visits
    value = (cookies[:visits] || 0).to_i
    cookies[:visits] = { value:(value + 1).to_s, :expires => Time.now + 10.seconds }
    @visits = cookies[:visits]
    cookies.delete :count_visits
  end



end
