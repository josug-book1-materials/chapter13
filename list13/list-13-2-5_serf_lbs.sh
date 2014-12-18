#!/bin/sh
case ${SERF_EVENT} in
    "member-join" | "member-failed" | "member-leave" )
        /opt/serf/lbs_members.pl
        /sbin/service nginx condrestart
esac

exit 0
