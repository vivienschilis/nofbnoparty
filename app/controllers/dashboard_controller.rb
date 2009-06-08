class DashboardController < ApplicationController
  before_filter :get_shared_objects
  
   def index
      render :action => :my_parties
   end
  
    def my_parties
      render "my_parties.fbml.erb"
    end
    
    def invitation_requests
      render "invitation_requests.fbml.erb"
    end
  
    def invited_parties
      render "invited_parties.fbml.erb"
    end
    
    def other_parties
      render "other_parties.fbml.erb"
    end
    
    def get_shared_objects
      @other_parties = Party.find(:all, :conditions => ["user_id <> ?", @user.id])
      @waiting_requests_number=0
      @user.parties.each do |party|
        @waiting_requests_number += party.waiting_requests.size
      end
      @waiting_requests_number += @user.pending_parties.size
      @waiting_requests_number += @user.requested_parties.size
    end
end