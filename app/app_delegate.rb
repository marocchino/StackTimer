class AppDelegate
  attr_accessor :status_menu

  def applicationDidFinishLaunching(notification)
    @app_name = NSBundle.mainBundle.infoDictionary['CFBundleDisplayName']
    @status_menu = NSMenu.new
    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).init
    @status_item.setMenu(@status_menu)
    @status_item.setHighlightMode(true)
    @status_item.setTitle(@app_name)

    @status_menu.addItem createMenuItem("Start", 'start_timer')
    @status_menu.addItem createMenuItem("Finish", 'stop_timer')
    @status_menu.addItem createMenuItem("Quit", 'terminate:')
  end

  def createMenuItem(name, action)
    NSMenuItem.alloc.initWithTitle(name, action: action, keyEquivalent: '')
  end

  def start_timer
    task = Task.new("test")
    @timer = EM.add_periodic_timer 1.0 do
      @status_item.setTitle(task.display)
    end
  end

  def stop_timer
    @timer && EM.cancel_timer(@timer)
    @timer = nil
    @status_item.setTitle(@app_name)
  end
end
