class MyCustomMailer < ApplicationMailer
  def notify_manager
    mail(to: params[:email], subject: add_prefix('hello'))
  end
end