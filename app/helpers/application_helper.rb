module ApplicationHelper
  def user_path?
    current_page?(new_user_session_path()) ||
        current_page?(user_session_path()) ||
        current_page?(new_user_password_path()) ||
        current_page?(edit_user_password_path()) ||
        current_page?(cancel_user_registration_path()) ||
        current_page?(new_user_registration_path()) ||
        current_page?(edit_user_registration_path())
  end

  def not_user_path?
    !user_path?
  end
end
