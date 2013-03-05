helpers do

  def partial(template, locals = {})
    haml("_#{template}".to_sym, :layout => false, :locals => locals)
  end

end
