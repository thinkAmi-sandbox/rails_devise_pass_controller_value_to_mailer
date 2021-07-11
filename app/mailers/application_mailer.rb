class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  before_action :set_controller_value, if: -> { params.present? }

  protected

  def add_prefix(subject)
    "[#{@controller_value}] #{subject}"
  end

  private

  def set_controller_value
    @controller_value = params&.fetch(:controller_value)
  end
end
