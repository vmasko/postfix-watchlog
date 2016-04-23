ROOT = File.expand_path("../../", __FILE__)

$log_path = "#{ROOT}/tmp/example.log"   # Path to the Postfix log
$out_path = "#{ROOT}/tmp/output.out"    # Path to the output file
$line     = "bounce|deferred"           # Select lines with the specified words
$string   = "(?<=to=<)(.*)(?=>.)"       # Extract this string from the line (default gets "to=<user_email>")
$type     = :bounced                    # Type of the messages sent to receiver
$address  = "http://localhost:9000"     # Address of the listening server
