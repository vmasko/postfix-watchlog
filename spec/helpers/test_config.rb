# Time zone (list—https://goo.gl/oerj22)
ENV['TZ'] = "Europe/Moscow"

# Path to the log
$log_path = "spec/helpers/test_file.log"

# Address of the server
$address = "http://localhost:9000"

# Regexp: look for the lines with this words inside
$line = "bounce|deferred"

# Regexp: grab this data from the line and send it to the server
# (now it looks for to=<user@email.com>)
$string = "(?<=to=<)(.*)(?=>.)"

# Minimum number of the records to send with ONE request
$threshold = 10

# Head of the outgoing hash (to tell the server what happened with
# that records—e.g. { bounced: [{ email: time }, { email: time }] })
$type = :bounced
