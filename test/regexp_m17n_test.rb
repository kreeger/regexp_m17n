# encoding: utf-8
require 'minitest/autorun'
require_relative '../lib/regexp_m17n'

class RegexpTest < MiniTest::Unit::TestCase
  def test_non_empty_string
    Encoding.list.each do |enc|
      next if %w(ISO-2022-JP ISO-2022-JP-2 UTF-7).include?(enc.to_s)
      encoded = '.'.encode(enc)
      assert(RegexpM17N.non_empty?(encoded))
    end
  end
end
