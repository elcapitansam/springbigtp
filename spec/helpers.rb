module Helpers
  def each_printable_char_except_in(except_str)
    (32..126).map(&:chr).select { |ch|
      !except_str.include?(ch)
    }.each { |ch| yield ch }
  end
end