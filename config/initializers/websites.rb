
# Grab website icons so we can badge member links
WEBSITES = Dir.entries("#{Rails.root}/app/assets/images/application/social"). \
               select{|f| f.match(/\_32/)}. \
               map{|f| f.gsub(/\_32\.png/,'')}

# Icons are Creative Commons via:
# http://www.komodomedia.com/blog/2009/06/social-network-icon-pack/#icons
