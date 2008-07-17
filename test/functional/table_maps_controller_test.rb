require File.dirname(__FILE__) + '/../test_helper'
require 'table_maps_controller'

# Re-raise errors caught by the controller.
class TableMapsController; def rescue_action(e) raise e end; end

class TableMapsControllerTest < Test::Unit::TestCase
  fixtures :table_maps

  def setup
    @controller = TableMapsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = table_maps(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:table_maps)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:table_map)
    assert assigns(:table_map).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:table_map)
  end

  def test_create
    num_table_maps = TableMap.count

    post :create, :table_map => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_table_maps + 1, TableMap.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:table_map)
    assert assigns(:table_map).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      TableMap.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TableMap.find(@first_id)
    }
  end
end
