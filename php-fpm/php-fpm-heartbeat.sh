#!/usr/bin/bash
#
# resarts PHP FPM if it dies
#
pool_count=$(systemctl status php-fpm | grep -o "pool" | wc -l)

if [ "$pool_count" -gt 40 ]; then
    systemctl restart php-fpm >> /var/log/aeu.log
    echo "`date` - php-fpm not running.  Restart required" >> /var/log/aeu.log;
fi

