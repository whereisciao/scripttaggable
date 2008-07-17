class TableMapsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @table_map_pages, @table_maps = paginate :table_maps, :per_page => 10
    @tables = TableMap.find_by_sql("select distinct glyph from table_maps order by glyph;")
  end

  def show
    @table_map = TableMap.find(params[:id])
  end

  def new
    @table_map = TableMap.new
  end

  def create
    @table_map = TableMap.new(params[:table_map])
    if @table_map.save
      flash[:notice] = 'TableMap was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @table_map = TableMap.find(params[:id])
  end

  def update
    @table_map = TableMap.find(params[:id])
    if @table_map.update_attributes(params[:table_map])
      flash[:notice] = 'TableMap was successfully updated.'
      redirect_to :action => 'show', :id => @table_map
    else
      render :action => 'edit'
    end
  end

  def destroy
    TableMap.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
