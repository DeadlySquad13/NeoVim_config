local leap_settings = require('config.Navigation.leap.settings')

return {
  labeled_modes = 'vo',
  multiline = false,
  opts = {
    safe_labels = leap_settings.safe_labels,
  }
}
