module AuthenticationHelper
  def sign_in(email, password)
    visit "/"
    click_link "Sign in"
    expect(page).to have_current_path("/users/sign_in")

    fill_in "Email", with: email
    fill_in "Password", with: password

    click_button "Log in"
  end
end
