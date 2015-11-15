class ApiConstraints
  def matches?(req)
    req.headers['Accept'].include?("application/vnd.grabyourpack")
  end

end
