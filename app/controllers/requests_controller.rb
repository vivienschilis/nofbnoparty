class RequestsController < ApplicationController
  def accept
    @request = Request.find(params[:id])
    if @request.sender_id or (@request.party.user_id == @user.id)
      @request.accepted_at=Time.zone.now
      @request.save
    end
    
    redirect_to dashboard_index_url
    
  end
end