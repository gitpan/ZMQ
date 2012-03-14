#!/usr/bin/env perl
use strict;
use ZMQ qw(ZMQ_PUB ZMQ_SNDHWM);

my ($host, $port);

if (@ARGV >= 2) {
    ($host, $port) = @ARGV;
} elsif (@ARGV) {
    if ($ARGV[0] =~ /^([\w\.]+):(\d+)$/) {
        ($host, $port) = ($1, $2);
    } else {
        $host = $ARGV[0];
    }
}
$host ||= '127.0.0.1';
$port ||= 5566;

my $ctxt = ZMQ::Context->new();
my $sock = $ctxt->socket(ZMQ_PUB);
$sock->bind( "tcp://$host:$port" );
$sock->setsockopt( ZMQ_SNDHWM, 10 );

my $count = 0;
while (1) {
    $count++;
    $sock->send("HELLO? $count");
    $sock->send("WORLD? $count");
    sleep 2;
}