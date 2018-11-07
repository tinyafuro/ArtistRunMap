class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #Railsの全コントローラからでもSessionヘルパーが使えるようになる
  include SessionsHelper

end
