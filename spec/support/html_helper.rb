module HTMLHelper
  def compress(lines)
    lines.split("\n").map { |line| line.gsub(/^\s+/,'') }.join("\n")
  end
end
