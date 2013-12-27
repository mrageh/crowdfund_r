def project_attributes(overrides = {})
  {
    name: "Start-Up Project",
    description: "A description of a start-up project",
    target_pledge_amount: 100.00,
    pledging_ends_on: 1.day.from_now,
    website: "http://project-a.com",
    team_members: "awesome",
    image_file_name: "boom.png"
  }.merge(overrides)
end
