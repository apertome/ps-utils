#!/usr/bin/perl

# Given an array of hostnames/addresses, this script runs throughput tests
# between all the hosts, in both directions

my @hosts = (
    'host1',
    'host2'
);

# flags to send to pscheduler. here we're setting the window to 128M
my $pscheduler_flags = '-w 128M';

# currently we're hard-coded to throughput but should make this more flexible
my $pscheduler = '/usr/bin/pscheduler task throughput ';

my $source  = $hosts[0];
my $destination = $hosts[1];

foreach my $ordered ([$source, $destination], [$destination, $source]) {
    my ($src, $dst) = @$ordered;

    print "Source: $src\n";
    print "Destination: $dst\n";

    my $command = $pscheduler . " --source $src --dest $dst ";
    $command .= $pscheduler_flags;

    print "Command: " . $command . "\n";
    my $output = `$command`;
    print "Output:\n$output\n";
}

sub host_pairs {
    my ($hosts) = @_;

}
