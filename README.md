##bounce-keeper

**bounce-keeper** is a simple parser for the logs produced by the **Postfix** MTA—it captures messages with `deferred` and `bounce` statuses, wraps their parameters into JSON and sends it to the receiver with a POST request.
