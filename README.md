##watchlog-client

**Watchlog** is a simple log parser written in **Ruby**—it tails the specified log file, grabs the matching lines, packs the required parameters into a JSON hash and sends it to the receiver with a POST request.

###Usage
Update the **bin/config.rb** file before the first run, then launch `ruby bin/watchlog`.
