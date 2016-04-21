module ProjectHelpers
  def create_project(title)
    find(".menu_section").find(".add_item.fa-plus").click
    fill_in 'title', with: title
    click_button 'Create'
  end

  def archive_current_project
    find(".project-settings").find(".fa-cog").click
    click_link 'Archive project'
    fill_in 'project_password', with: '123456'
    click_button "Yes, I confirm this action."
  end

end
