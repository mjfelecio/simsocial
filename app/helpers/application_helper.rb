module ApplicationHelper
  def posted_time(resource)
    created_at = resource.created_at
    "#{time_ago_in_words(created_at)} ago"
  end
end
