##postfix-watchlog

**Watchlog** is a simple parser for the logs produced by the **Postfix** MTA—it captures messages with certain statuses, wraps their parameters into JSON and sends it to the receiver with a POST request.

###Prerequisites
Ruby 2.2.4, bundler.

###Usage
Specify path of the log at **bin/watchlog** before the first run, then launch:

```
$ bundle install
$ ruby bin/watchlog
```
