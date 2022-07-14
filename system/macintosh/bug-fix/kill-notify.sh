# !bin/sh
pid=$(ps -ax | grep UserNotificationCenter | awk '{print $1}'| head -1)
sudo kill -9 $pid
