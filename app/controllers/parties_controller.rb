class PartiesController < ApplicationController
  # GET /parties
  # GET /parties.xml
  def index
    @parties = Party.all

    respond_to do |format|
      format.fbml
    end
  end

  # GET /parties/1
  # GET /parties/1.xml
  def show
    @party = Party.find(params[:id])
    @bring_by_others = Something.find_all_by_party_id(@party.id, :conditions => ["user_id <> ?", @user.id])
    
    @bring_by_me = Something.find_all_by_user_id_and_party_id(@user.id, @party.id)
    @something = Something.new
    
    if Request.find_by_user_id_and_party_id(@user.id, @party.id, :conditions => "accepted_at is NULL")
      @requested=true
    else
      @requested=false
    end
    
    if @party.invited_users.include?(@user)
      @invited=true
    else
      @invited=false
    end

    respond_to do |format|
      format.fbml 
    end
  end

  # GET /parties/new
  # GET /parties/new.xml
  def new
    @party = Party.new
    @party.date = Time.zone.now

    respond_to do |format|
      format.fbml      
    end
  end

  # GET /parties/1/edit
  def edit
    @party = Party.find(params[:id])
  end

  # POST /parties
  # POST /parties.xml
  def create
    @party = Party.new(params[:party])
    @party.user_id=@user.id
    
    respond_to do |format|
      if @party.save
        Request.create(:user_id => @user.id, :party_id => @party.id, :accepted_at => Time.zone.now)
        FacebookPublisher.deliver_new_party_notification (facebook_session.user,facebook_session.user.friends_with_this_app, @party)
        
        flash[:notice] = 'Party was successfully created.'
        format.fbml { redirect_to dashboard_index_url }
        
      else
        format.fbml { render :action => "new" }        
      end
    end
  end

  # PUT /parties/1
  # PUT /parties/1.xml
  def update
    @party = Party.find(params[:id])

    respond_to do |format|
      if @party.update_attributes(params[:party])
        flash[:notice] = 'Party was successfully updated.'
        format.fbml { redirect_to(@party) }
      else
        format.fbml { redirect_to(@party) }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.xml
  def destroy
    @party = Party.find(params[:id])
    @party.destroy

    respond_to do |format|
      format.fbml { redirect_to(@party) }
      
    end
  end
  
  def invitation
    @party = Party.find(params[:id])
        
       Request.create(:user_id => @user.id, :party_id => @party.id)
       
       respond_to do |format|
         format.fbml { redirect_to dashboard_index_url }
       end
  end
  
  
  def publish
    @party = Party.find(params[:id])
    @bring_by_me = Something.find_all_by_user_id_and_party_id(@user.id, @party.id)
    
    if @bring_by_me.empty?
      things ="Nothing, I eat exclusivly what the others bring"
    else  
      things=@bring_by_me.map { |s| s.quantity.to_s + " " + s.item }
      things = things.join(" and ")
    end
    
    template_data = {
      :things => things,
      :party_date => @party.date.to_s
    }
    
    url = dashboard_index_url

    data = { :template_id => '74549969634',
            :template_data => template_data
    }

    feedStory = { 
          :method  => 'feedStory',
          :content => { :feed => data,
                        :next => url }
    }

    render :text => feedStory.to_json
    
  end
  
  def invite_friends
    @party = Party.find(params[:id])
    
    if @party.invited_users.include?(@user)
      if (params[:ids])
        params[:ids].each do |id|
          friend=User.find_or_create_by_facebook_id(id)
          Request.create(:user_id => friend.id, :party_id => @party.id, :sender_id => @user.id)
        end
      end
    end
    
    respond_to do |format|
       format.fbml { redirect_to(@party) }
     end
    
  end
  
  def leave
    @party = Party.find(params[:id])
    
    
    request = Request.find_by_user_id_and_party_id(@user.id, @party.id)
    
    respond_to do |format|
      if request.destroy
        flash[:notice] = 'You have successfully leaved the party.'
        format.fbml { redirect_to dashboard_index_url }
      else
        flash[:notice] = 'An error occured when you have tried to leaved the party.'
        format.fbml { redirect_to(@party) }
      end
    end
  end
  
end
