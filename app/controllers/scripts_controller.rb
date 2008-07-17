class ScriptsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @script_pages, @scripts = paginate :scripts, :per_page => 10, :order => 'title'
    @tags = Script.tag_counts
    @tags.sort! {|a,b| a.name <=> b.name}
  end

  def list_tags
     @scripts = Script.find_tagged_with(params[:tag], :order => 'title')
  end

  def tag
     @script = Script.find(params[:id])
  end

  def show
    @script = Script.find(params[:id])
    @tableMap = TableMap.find_all_by_scripts_id(@script, :order => 'glyph')
  end

  def new
    @script = Script.new
  end

  def save
    @script = Script.find(params[:id])
    if @script.update_attributes(params[:script])
      flash[:notice] = "#{@script.title} was tagged with #{@script.tag_list}"
      redirect_to :action => 'tag', :id => @script.id + 1
    else
      render :action => 'tag', :id => @script
    end
  end
     

  def create
    @script = Script.new(params[:script])
    if @script.save
      flash[:notice] = 'Script was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @script = Script.find(params[:id])
  end

  def update
    @script = Script.find(params[:id])
    if @script.update_attributes(params[:script])
      flash[:notice] = 'Script was successfully updated.'
      redirect_to :action => 'show', :id => @script
    else
      render :action => 'edit'
    end
  end

  def destroy
    Script.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def get_results
    if request.xhr?
      if params['search_text'].strip.length > 0
        terms = params['search_text'].split.collect do |word|  
          "%#{word.upcase}%" 
        end     
        @scripts = Script.find(
          :all,   
          :conditions => [
            ( ["(LOWER(title) LIKE ?)"] * terms.size ).join(" AND "),
            * terms.flatten
          ]       
        )       
      end     
      render :partial => "search"
    else    
      redirect_to :action => "index" 
    end
  end


end
