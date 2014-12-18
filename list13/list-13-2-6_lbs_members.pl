#!/usr/bin/perl

my $count = 0;
if (open(SERF, "/usr/local/bin/serf members -tag role=web |")) {
    if (open (CONF,"> /etc/nginx/conf.d/lbs_upstream.conf")) {
        print CONF "upstream web-server {\n";
        foreach my $serf (<SERF>) {
            if ($serf =~ /^(\S+)(\s+)(\S+)(\:)(\d+)(\s+)(\w+)/) {
                my $STAT = " down" if ($7 ne 'alive');
                print CONF " server ".$3.":80".$STAT.";\n";
                $count++;
            }
        }
        print CONF " server 127.0.0.1:80 down;\n" if ($count == 0);
        print CONF "}\n";
    }
    close(SERF);
}

exit;

