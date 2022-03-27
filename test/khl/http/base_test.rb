# frozen_string_literal: true

require_relative "../../test_helper"

class HTTPBaseTest < Minitest::Test
  class Thing < KHL::HTTP::Base
    def list
      get
    end

    def list_with_params
      get
    end

    def get
      action_name
    end
  end

  def setup
    @thing = Thing.new(token: "foobar")
  end

  def test_filter_params
    params = {
      key1: "value1",
      key2: nil
    }

    assert_equal({"key1" => "value1"}, @thing.send(:filter_params, params))
    assert_equal({}, @thing.send(:filter_params, nil))
  end

  def test_resource_name
    assert_equal("thing", @thing.send(:resource_name))
  end

  def test_action_name
    assert_equal("list", @thing.list)
    assert_equal("list-with-params", @thing.list_with_params)
  end
end
