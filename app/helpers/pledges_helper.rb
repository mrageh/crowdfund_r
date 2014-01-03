module PledgesHelper
  def pledge_link(project)
    unless project.fully_funded?
      link_to "Pledge!", new_project_pledge_path(project), class: "button ok pledge"
    end
  end

  def funded?(project)
    if project.fully_funded?
      content_tag :p, "Fully Funded!"
    else
      content_tag :p, number_to_currency(project.outstanding_amount)
    end
  end
end
