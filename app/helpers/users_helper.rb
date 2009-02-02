module UsersHelper
  def linkify(str, separator = "\n")
    str.split(separator).collect {|link| link_to link, link}.join '<br />'
  end
end
