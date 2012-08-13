Spine = require('spine')
$ = Spine.$

Spine.h or={}

# Extending Spine.Controller to support actions
add_actions = (controller, actions) ->
  controller.actions = {} unless controller.actions

  Spine.container or=[]

  Spine.container.push controller unless \
    controller in Spine.container

  _exec = (func_name) ->
      ->
          controller[func_name] arguments...
          controller.active()

  for route, func_name of actions
    if typeof controller[func_name] == "function"
      controller.actions[func_name] = route
      controller.route(route, _exec func_name)


url_for = (controller_name, action, parameters...) ->
  ControllerType = require "controllers/#{controller_name}"
  _controller_name = new ControllerType().constructor.name

  hashStrip    = /^#*/
  namedParam   = /:([\w\d]+)/g
  splatParam   = /\*([\w\d]+)/g
  escapeRegExp = /[-[\]{}()+?.,\\^$|#\s]/g

  for controller in Spine.container
    if controller.constructor.name == _controller_name
      url_path = controller.actions[action]
      url_path = url_path.replace(hashStrip, '')
        .replace(splatParam, '')
        .replace(namedParam, '')
        .replace(escapeRegExp, '')
      url_path += parameters.join('/')

  url_path

Spine.h.url_for = url_for
Spine.Controller::add_actions = add_actions
