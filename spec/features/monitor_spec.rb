require 'spec_helper'

feature "Monitoring" do 
	scenario "User visit monitoring page" do 
		visit "/monitor"

		expect(page).to have_text("HPU")
	end
end