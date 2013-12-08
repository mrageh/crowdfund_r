module ProjectsHelper
  def format_project_pending(project)
    if project.pledging_expired?
      content_tag(:strong, "All Done!")
    else
      distance_of_time_in_words(Date.today, project.pledging_ends_on) + " remaining"
    end
  end
end
