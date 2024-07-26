# app/controllers/audit_logs_controller.rb
class AuditLogsController < ApplicationController
  before_action :authorize_super_user

  def index
  end

  def users
    @audits = Audited::Audit.where(auditable_type: 'User').order(created_at: :desc)
    render partial: 'users'
  end

  def students
    @audits = Audited::Audit.where(auditable_type: 'Student').order(created_at: :desc)
    render partial: 'students'
  end

  def options
    @audits = Audited::Audit.where(auditable_type: 'Option').order(created_at: :desc)
    render partial: 'options'
  end

  def notes
    @audits = Audited::Audit.where(auditable_type: 'Note').order(created_at: :desc)
    render partial: 'notes'
  end

  def student_options
    @audits = Audited::Audit.where(auditable_type: 'StudentOption').order(created_at: :desc)
    render partial: 'student_options'
  end

  private

  def authorize_super_user
    redirect_to root_path, alert: I18n.t('unauthorized') unless current_user&.role == 'super_user'
  end
end
