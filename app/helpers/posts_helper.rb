module PostsHelper
  def format_post_body(body)
    output = []
    body.split("\n\n").map do |paragraph|
      output << tag.p(paragraph)
    end
    safe_join(output)
  end

  def truncate_post(body)
    body.split("\n\n").first
  end
end
