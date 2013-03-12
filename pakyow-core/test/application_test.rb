require 'support/helper'

class ApplicationTest < MiniTest::Unit::TestCase
  def test_application_path_is_set_when_inherited    
    assert(Pakyow::Configuration::App.application_path.include?(app_test_path))
  end
  
  def test_application_runs
    app(true).run(:test)
    assert_equal(true, app.running?)
  end
  
  def test_is_not_staged_when_running
    app(true).run(:test)
    assert_same(false, app.staged?)
  end

  def test_application_does_not_run_when_staged
    app(true).stage(:test)
    assert_equal false, app.running?
  end
  
  def test_detect_staged_application
    app(true).stage(:test)
    assert_equal(true, app.staged?)
  end
  
  def test_base_config_is_returned
    assert_equal(Pakyow::Configuration::Base, app(true).config)
  end
  
  def test_configuration_is_stored
    app(true).stage(:test)
    assert !app.configurations[:test].nil?
  end

  def test_env_is_set_when_initialized
    envs = [:test, :foo]
    app(true).stage(*envs)
    assert_equal(envs.first, Pakyow.app.env)
  end
  
  def test_app_is_set_when_initialized
    app(true)
    assert_nil(Pakyow.app)
    app(true).run(:test)
    assert_equal(TestApplication, Pakyow.app.class)
  end
  
  def test_app_is_loaded_for_each_request_in_dev_mode_only
    # TODO
  end
  
  protected
  
  def app(do_reset = false)
    TestApplication.reset(do_reset)
  end

  def app_test_path
    File.join('test', 'support', 'app.rb')
  end
  
end
