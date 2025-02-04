class ApplicationController < ActionController::Base
  include ResourceExtensions
  include TraficExtensions
  include ResponseExtensions
  include DeviseExtensions
  include CustomsExtensions
  include ToggleExtensions
  include RegionsExtensions
  include NotificationExtensions
  include Pundit::Authorization

  protect_from_forgery with: :exception
  process_regions_params

  rescue_from Pundit::NotAuthorizedError, with: :access_denied

  before_action do
    # there MUST be a cleaner way :/
    if Rails.env.development?
      paths = Rails.application.paths['app/models'].to_a
      Rails.application.railties.each do |tie|
        next unless tie.respond_to? :paths
        paths += tie.paths['app/models'].to_a
      end

      paths.each do |path|
        next unless File.directory?(path)
        Dir.chdir path do
          Dir['**/*.rb'].each do |src|
            TPrint.debug "loading #{src[0..-4].classify}"
            src[0..-4].classify.constantize rescue nil
          end
        end
      end
    end
  end

  def robots
    render text: ""
  end

  def is_admin?
    false
  end

  def controller_namespace
    []
  end

  def reject_unauthorized_user!
    unauthorized unless current_user.present? && current_user.is_admin?
  end
end
