class ApplicationController < ActionController::Base
  def index
    raw = services[:index].call.value
    head(:no_content) && return if raw.blank?
    render html: raw.html_safe, layout: false
  end

  def services
    {
      index: Catch::Client::Web::FetchIndex
    }
  end
end
