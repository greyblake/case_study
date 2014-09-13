class AuthorizedController < ApplicationController
  before_filter :ensure_current_user

  # Redirect to home unless user is not signed in.
  #
  # @return [void]
  private def ensure_current_user
    redirect_to root_path unless current_user
  end
end
