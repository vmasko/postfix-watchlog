module Watchlog
  class Parser
    TYPES = {
      /no dns a-data returned|unrouteable|421 4.2.1|network.*unreachable/i => 'DNS error',
      /malware/i =>                                                           'Malware suspicion',
      /auth.*required|without rfc|encryption.*required/i =>                   'Authentication error',
      /rcpt.*restriction|allowed rcpt|drd.*domain/i =>                        'RCPT restriction',
      /not.*configured|configuration problem/i =>                             'Service is not configured',
      /service.*unavailable|(?:read|look up).*error/i =>                      'Service unavailable',
      /network.*block/i =>                                                    'Network is on block list',
      /not so fast|550 reject/i =>                                            'Sender address rejected',
      /recipient rejected|invalid recipient/i =>                              'Recipient address rejected',
      /(?:mail|domain).*loop/i =>                                             'Domain loops back',
      /domain.*exist/i =>                                                     'Domain does not exist',
      /domain.*quota/i =>                                                     'Domain quota exceeded',
      /domain.*suspended/i =>                                                 'Domain is suspended',
      /no route.*host/i =>                                                    'No route to host',
      /host.*(?:grey list|greylist|greylist)/i =>                             'Host greylisted',
      /host.*(?:black list|blacklist)/i =>                                    'Host blacklisted',
      /host.*not found/i =>                                                   'Host not found',
      /user banned/i =>                                                       'User banned',
      /not yet registered|no.*(?:user|recipient)|no mailbox/i =>              'User not found',
      /bad destination|have.*account|unkown user|cannot find|553 5.3.0/i =>   'User not found',
      /isn't allowed|unsolicited|illegal attempts/i =>                                 'Sender blacklisted',
      /rejected.*policy|policy.*violation|your IP.*blacklist|mail.*prohibited/i =>     'Sender blacklisted',
      /(?:stop|accept|allow|as|dispatch|detect|reject|consider).*spam|spammer/i =>     'Spam suspicion',
      /log in to enable|550 disabled/i =>                                              'Account disabled',
      /(?:mailbox|account|receiving).*(?:frozen|disabled|blocked)/i =>                 'Account disabled',
      /invalid argument|internal error/i =>                                            'Temporarily deferred',
      /local.*problem|command not allowed|check.*clock/i =>                            'Temporarily deferred',
      /temp.*(?:deferred|rejected|failure|error)|try.*(?:again|later)/i =>             'Temporarily deferred',
      /(?:does not|sender|address|message).*(?:sender|reject|denied|fail)/i =>         'Sender address rejected',
      /(?:user|recipient|account|mailbox).*(?:found|unknown|exist|unavail|allow)/i =>  'User not found',
      /relay.*(?:denied|permitted|unavailable)|(?:prohibited|unable).*relay/i =>       'Relaying denied',
      /(?:account|mailbox|quota|user).*(?:full|exceed|quota|error)|\d\sover quota/i => 'Mailbox is full',
      /timed out|connection.*(?:refused|limit)|(?:many|lost).*connection/i =>          'Connection error'
    }
  end
end
