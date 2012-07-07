Spine = require('spine')
$ = Spine.$

Spine.h or={}

# Extending Spine.Controller to support actions
add_actions = (actions) ->
  @actions = {} unless @actions

  Spine.container or=[]

  if @ not in Spine.container
    Spine.container.push @

  $.each actions, (route, func_name) =>
    @actions[func_name] = route

    if typeof @[func_name] == "function"
      new_func_name = "__execute_action_#{func_name}"

      @[new_func_name] = =>
        @[func_name](arguments...)
        @.active()

      @route(route, @[new_func_name])


url_for = (controller_name, action, parameters...) =>

  hashStrip    = /^#*/
  namedParam   = /:([\w\d]+)/g
  splatParam   = /\*([\w\d]+)/g
  escapeRegExp = /[-[\]{}()+?.,\\^$|#\s]/g

  url_path = ""
  for controller in Spine.container
    if controller.constructor.name == controller_name
      #url_path =  Spine.clean_from_regexp(controller.actions[action])
      url_path = controller.actions[action]
      url_path = url_path.replace(hashStrip, '')
        .replace(splatParam, '')
        .replace(namedParam, '')
        .replace(escapeRegExp, '')
      url_path += parameters.join('/')
      return url_path

Spine.h.url_for = url_for
Spine.Controller::add_actions = add_actions
