helpers do

  def partial(template, locals = {})
    haml("_#{template}".to_sym, :layout => false, :locals => locals)
  end

  def current_user
    return session[:login]
  end
end
