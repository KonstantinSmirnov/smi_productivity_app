module TaskHelpers
  def create_task(text)
    fill_in "new-task-field", with: text
    click_button "Add"
  end 
end