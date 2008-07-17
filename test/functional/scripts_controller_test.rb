require File.dirname(__FILE__) + '/../test_helper'
require 'scripts_controller'

# Re-raise errors caught by the controller.
class ScriptsController; def rescue_action(e) raise e end; end

class ScriptsControllerTest < Test::Unit::TestCase
  fixtures :scripts

  def setup
    @controller = ScriptsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = scripts(:first).id
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

    assert_not_nil assigns(:scripts)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:scripts)
    assert assigns(:scripts).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:scripts)
  end

  def test_create
    num_scripts = Scripts.count

    post :create, :scripts => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_scripts + 1, Scripts.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:scripts)
    assert assigns(:scripts).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Scripts.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Scripts.find(@first_id)
    }
  end
end
