# frozen_string_literal: true

# This is application mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def test_email
    mail(to: 'test@example.com', subject: I18n.t('student_imported')) do |format|
      format.text { render plain: 'This is a test email' }
    end
  end
end
