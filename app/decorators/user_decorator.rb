class UserDecorator < Draper::Decorator
  delegate_all

  def get_user_token
    token
  end


end
