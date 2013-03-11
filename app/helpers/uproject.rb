helpers do

  def partial(template, locals = {})
    haml("_#{template}".to_sym, :layout => false, :locals => locals)
  end

  def current_user
    return session[:login]
  end

  def display_status_mahasiswa(smt)
    if smt == 0
      return "Alumni"
    else
      return "Semester #{smt}"
    end
  end
end
