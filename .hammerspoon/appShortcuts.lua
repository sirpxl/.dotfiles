function shortcut_template(__self, mod, key, action)
  local keybind = hs.hotkey.new(mod, key, function()
    action()
  end)
  local watcher = hs.application.watcher.new(function(name, eventType, app)
    if eventType ~= hs.application.watcher.activated then return end
    if name == __self.appName then
      keybind:enable() -- Enable the shortcut if the current activated app is the app_name you specified
    else
      keybind:disable() -- Disable otherwise
    end
  end)
  watcher:start()
end

-- Preview custom shortcuts
Preview = {
  appName = 'Preview',
  cropSaveClose = shortcut_template,
}

Preview:cropSaveClose({'cmd', 'option'}, 's', function()
  hs.eventtap.keyStroke({'cmd'}, 'k')
  hs.eventtap.keyStroke({'cmd'}, 's')
  hs.eventtap.keyStroke({'cmd'}, 'w')
end)

-- Finder custom shortcuts
Finder = {
  appName = 'Finder',
  openVolumes = shortcut_template,
}

Finder:openVolumes({'shift', 'option'}, 'v', function()
  hs.execute('open /Volumes')
  hs.alert('Volumes Folder Opened')
end)
