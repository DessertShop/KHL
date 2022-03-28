# frozen_string_literal: true

require_relative "../test_helper"

class VersionTest < Minitest::Test
  def has_a_version_number
    refute_nil KHL::VERSION
  end
end
