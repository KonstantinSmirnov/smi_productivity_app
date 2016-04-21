module StatusesHelper
  def create_status(text, color='red')
    click_link "Statuses"
    fill_in "status-text-area", with: text
    within ".comment-form .controls" do
      select color, :from => "color"
    end
    click_button 'Add'
  end
end
