url_for_for_spine
=================

Helper for extending Spine controllers functionality. 
Adds support for generating dynamic urls by name of controller and action. Just like in Pylons.


Usage
=================

1. Setup routing as described here <a href="http://spinejs.com/docs/routing">Spine Routing</a>

```CoffeeScript
Route = require('lib/route')
Route.setup()
```

2. Put url_for_extender.coffee file to your lib folder in spine app.
3. Import it somewhere (require('lib/url_for_extender')
4. Add some actions to controller by calling add_actions in controllers constructor.
You don't have to need to care about routing - all this is done behind the scene by actions.

```CoffeeScript

class MyController extends Spine.Controller

  constructor: ->
    super
    @add_actions @,
      "/index":"index"
      "/object/edit/:id" : "edit"

  index: (args) =>
    # Some logic processing.

  edit: (args) =>
    id = args.id
```

### How to get url?

After importing url_for_extender you have helper object in Spine.
So, when you need to get some url just use:
```CoffeeScript
Spine.h.url_for('ControllerName', 'action', param1, param2 e.t.c.)
```

and you will get url.

### using url_for in eco templates.
Also is true for templates.
```eco
<% h = require('spine').h %>
<a href="#<%= h.url_for('MyController', 'edit', 7) %>">edit</a>
```

this will render the folowing:
```html
<a href="#object/edit/7">edit</a>
```
