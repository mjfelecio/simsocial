RailsToastify.setup do |configuration|
  configuration.position = "toast-container-top-right"
  configuration.notice_animation = "slide" # bounce, slide, flip, zoom
  configuration.alert_animation = "slide" # bounce, slide, flip, zoom
  configuration.notice_duration = 2000
  configuration.alert_duration = 2000
  configuration.notice_theme = "light" # light, dark
  configuration.alert_theme = "light" # light, dark
  configuration.notice_type = "success" # default, success, warning, error, info
  configuration.alert_type = "error" # default, success, warning, error, info
end
