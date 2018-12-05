class ApplicationController < ActionController::Base
  def index
    html = services[:index].call.value.html_safe
    render html: html, layout: false
  end

  def services
    {
      index: Catch::Client::Web::FetchIndex
    }
  end
end
