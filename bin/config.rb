ROOT = File.expand_path("../../", __FILE__)

$log_path = "./tmp/example.log"   # Full path to the Postfix log
$line     = "bounce|deferred"     # Select lines with the specified words
$string   = "(?<=to=<)(.*)(?=>.)" # Extract this string from the line (default gets "to=<user_email>")
$type     = "bounced"             # Type of the messages sent to receiver
