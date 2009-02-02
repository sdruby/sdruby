class FuzzyFixture
  def phone
    area = string(:max => 3, :min => 3, :characters => :numeric)
    prefix = string(:max => 3, :min => 3, :characters => :numeric)
    suffix = string(:max => 4, :min => 4, :characters => :numeric)
    return "#{area}-#{prefix}-#{suffix}"
  end
end