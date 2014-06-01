# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'
require 'bubble-wrap/reactor'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.version = "0.0.1"
  app.name = 'StackTimer'
  app.info_plist['LSUIElement'] = true
end

task :"build:simulator" => :"schema:build"
