App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    $('form').addClass('connected').on 'submit', (e) =>
      e.preventDefault()
      @perform 'notification', post: $(e.target).serialize()
      false

  disconnected: ->
    $('form').removeClass('connected').off 'submit'

  received: (data) ->
    @message data["post"] if data["post"]

  message: (post)->
    $('table tbody').append(post);
