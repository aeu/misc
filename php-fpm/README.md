## PHP-FPM heartbeat

I noticed on my servers that php-fpm would stop responding to
requests, but it wasn't actually dead.  After looking around I found
that people were asking about this on StackOverflow, so apparently
it's a thing.

The reason this is happening is that php-fpm maxes out pools, but
keeps running.  You think its alive, but it isnt.  If you do a
systemctl status php-fpm you get something back that looks like this:

     # systemctl status php-fpm
     ● php-fpm.service - The PHP FastCGI Process Manager
          Loaded: loaded (/usr/lib/systemd/system/php-fpm.service; disabled; preset: disabled)
          Active: active (running) since Wed 2025-02-12 16:57:25 UTC; 2 days ago
        Main PID: 378180 (php-fpm)
          Status: "Processes active: 50, idle: 0, Requests: 5931, slow: 0, Traffic: 0.00req/sec"
           Tasks: 51 (limit: 10890)
          Memory: 266.1M
             CPU: 3min 22.585s
          CGroup: /system.slice/php-fpm.service
                  ├─378180 "php-fpm: master process (/etc/php-fpm.conf)"
                  ├─378181 "php-fpm: pool www"
                  ├─378182 "php-fpm: pool www"
                  ├─378183 "php-fpm: pool www"
                  ├─378184 "php-fpm: pool www"
                  ├─378185 "php-fpm: pool www"
                  ├─378187 "php-fpm: pool www"
                  ├─378224 "php-fpm: pool www"
                  ├─379205 "php-fpm: pool www"
                  ├─379207 "php-fpm: pool www"
                  ├─382316 "php-fpm: pool www"
                  ├─385428 "php-fpm: pool www"
                  ├─385430 "php-fpm: pool www"
                  ├─385431 "php-fpm: pool www"
                  ├─385432 "php-fpm: pool www"
                  ├─385436 "php-fpm: pool www"
                  ├─409352 "php-fpm: pool www"
                  ├─409360 "php-fpm: pool www"
                  ├─409361 "php-fpm: pool www"
                  ├─409366 "php-fpm: pool www"
                  ├─409367 "php-fpm: pool www"
                  ├─409368 "php-fpm: pool www"
                  ├─409369 "php-fpm: pool www"
                  ├─409375 "php-fpm: pool www"
                  ├─409376 "php-fpm: pool www"
                  ├─409377 "php-fpm: pool www"
                  ├─409378 "php-fpm: pool www"
                  ├─409379 "php-fpm: pool www"
                  ├─426730 "php-fpm: pool www"
                  ├─426731 "php-fpm: pool www"
                  ├─426732 "php-fpm: pool www"
                  ├─451531 "php-fpm: pool www"
                  ├─451533 "php-fpm: pool www"
                  ├─468298 "php-fpm: pool www"
                  ├─468313 "php-fpm: pool www"
                  ├─468314 "php-fpm: pool www"
                  ├─468315 "php-fpm: pool www"
                  ├─468316 "php-fpm: pool www"
                  ├─468317 "php-fpm: pool www"
                  ├─468318 "php-fpm: pool www"
                  ├─468319 "php-fpm: pool www"
                  ├─468320 "php-fpm: pool www"


So I wrote a script that counts the pools and restarts so that my
servers don't die.  I also posted my response on StackOverflow.  Now
to see if Cunningham's Law is proven.