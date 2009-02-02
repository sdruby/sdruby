class FuzzyFixture
  def email
    box = string(:max => 25, :characters => :alphanumeric)
    address = string(:max => 40, :characters => :alphanumeric)
    tla = @tlas[rand @tlas.size]
    return box + "@" + address + "." + tla
  end
end
