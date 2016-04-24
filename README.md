##watchlog-client

**Watchlog** is a configurable log parser written in **Ruby**—it tails the specified log file, grabs the matching lines, packs the required parameters into a JSON hash and sends it to the receiver with a POST request.

###Prerequisites
Ruby 2.2.4, bundler.

###Usage
Update the **bin/config.rb** file before the first run, then launch:

```
$ bundle install
$ ruby bin/watchlog
```
