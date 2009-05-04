class HomeController < ApplicationController
  before_filter :login_required, :except => [ :index ]
  
  def index
    @home_message = HomeMessage.find(:first)
    
    messages = @home_message.description.split /\n+/
    
    if messages.length % 2
      # it's an odd number of paragraphs
      messages << "\n "
    else
      # it's an even number of paragraphs
      
    end
    
    @left_column = messages[0..(messages.length / 2)].join "\n"
    @right_column = messages[(messages.length / 2 + 1)..messages.length - 1].join "\n"
    
  end
  
  def edit
    @home_message = HomeMessage.find(:first)
  end
  
  def update
    @home_message = HomeMessage.find(:first)
    
    if @home_message.update_attributes(params[:home_message])
      flash[:notice] = 'Home message successfully saved!'
      redirect_to home_path
    else
      render :action => 'edit'
    end
  end

end
