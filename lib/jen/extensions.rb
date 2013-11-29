class String
  def plural?
    pluralize == self && singularize != self
  end

  def singular?; !plural? end

  def singular_and_plural
    [ singularize, pluralize ]
  end
end


