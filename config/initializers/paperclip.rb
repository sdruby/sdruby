# Joyent doesn't put "convert" or "identify", required by Paperclip, in the PATH.  We need to instruct it:
Paperclip.options[:image_magick_path] = "/opt/local/bin/" if Rails.env.production?
