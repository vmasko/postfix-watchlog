ROOT = File.expand_path("../../", __FILE__)

# Time zone (list—https://goo.gl/oerj22)
ENV['TZ'] = "Europe/Moscow"

# Path to the log
$log_path = "#{ROOT}/tmp/example.log"

# Address of the server
$address = "http://localhost:9000"

# Number of connection attempts, time to wait between them (in seconds)
$attempts = 10
$time = 15

# Regexp: look for the lines with this words inside
# (without slashes)
$line = "bounce|deferred"

# Regexp: grab this data from the line and send it to the server
# (without slashes; default: to=<user@email.com>)
$string = "(?<=to=<)(.*)(?=>.)"

# Minimum number of the records to send with ONE request
$threshold = 10

# Head of the outgoing hash (to tell the server what happened with
# that records—e.g. { bounced: [{ email: time }, { email: time }] })
$type = :bounced
