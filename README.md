##postfix-watchlog

**Watchlog** is a simple parser for the logs produced by the **Postfix** MTA—it captures messages with certain statuses, wraps their parameters into JSON and sends it to the receiver via HTTP. It does not require anything but Ruby environment to launch.

###Prerequisites
Ruby 2.2.4 (and bundler to run tests).

###Usage
Send mode:
```
$ env POSTFIX_API_ENDPOINT="<API address>" ruby bin/watchlog <log path>
# Example:
$ env POSTFIX_API_ENDPOINT="http://localhost:3000" ruby bin/watchlog /var/log/mail.log
```

Test mode:
```
$ ruby bin/watchlog <log path> test <output file path>
# Example:
$ ruby bin/watchlog /var/log/mail.log test output.log
```

Merge program to a single file:
```
$ ruby bin/merge <output file path>
```
