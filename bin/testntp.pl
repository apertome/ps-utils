#!/usr/bin/perl

# Given an array of hostnames/addresses, this script runs throughput tests
# between all the hosts, in both directions
#
#server owamp.chic.net.internet2.edu iburst
#server owamp.hous.net.internet2.edu iburst
#server owamp.losa.net.internet2.edu iburst
#server owamp.newy.net.internet2.edu iburst
#server chronos.es.net iburst
#server saturn.es.net iburst
#owamp.chic.net.internet2.edu
#owamp.hous.net.internet2.edu
#owamp.losa.net.internet2.edu
#owamp.newy.net.internet2.edu
#chronos.es.net
#saturn.es.net

my @hosts = (
    'owamp.chic.net.internet2.edu',
    'owamp.hous.net.internet2.edu',
    'owamp.losa.net.internet2.edu',
    'owamp.newy.net.internet2.edu',
    'chronos.es.net',
    'saturn.es.net'
);

my @hosts_known = (

    'owamp.atla.net.internet2.edu',
    'owamp.chic.net.internet2.edu',
    'owamp.salt.net.internet2.edu',
    'owamp.losa.net.internet2.edu',
    'chronos.es.net',
    'saturn.es.net',
    'time-c-g.nist.gov',
    'utcnist2.colorado.edu',
    'time-c-wwv.nist.gov',
    'nist1-chi.ustiming.org',
    'time-a.timefreq.bldrdoc.gov',
    'ntp-gatech.usno.navy.mil',
    'ntp-ucla.usno.navy.mil',
    'ntp-uw.usno.navy.mil',
    'time1.chpc.utah.edu',
    'time2.chpc.utah.edu',
    'time3.chpc.utah.edu',
    'ntp.hawaii.edu',
    'ns2.jp.apan.net',
    'ns.twgrid.org',
    'b.ntp.monipe.rnp.br',
    'c.ntp.monipe.rnp.br',
    'ntp1.cais.rnp.br',
    'time1.ethz.ch',
    'time2.ethz.ch',
    'vega.cbk.poznan.pl',
    'tempus1.gum.gov.pl',
    'ntp.itl.waw.pl',
    'ntp1.oma.be',
    'time.belnet.be',
    'ntp3.fau.de',
    'ntp2.gbg.netnod.se',
    'canon.inria.fr',
    'ntp.inrim.it',
    'ntp2.inrim.it',
    'ntp1.nl.net',
    'chronos.asda.gr',
    'ntp.litnet.lt'
);

my @hosts_new_test = (
    'ntps1.pads.ufrj.br',
    'utcnist2.colorado.edu',
    'timekeeper.isi.edu',
    'rackety.udel.edu',
    'mizbeaver.udel.edu',
    'otc1.psu.edu',
    'gnomon.cc.columbia.edu',
    'navobs1.gatech.edu',
    'navobs1.wustl.edu',
    'now.okstate.edu',
    'ntp.colby.edu',
    'ntp-s1.cise.ufl.edu',
    'time-a-g.nist.gov',
    'time-b-g.nist.gov',
    'time-c-wwv.nist.gov',
    'time-d-wwv.nist.gov',
    'time-a-b.nist.gov',
    'time-b-b.nist.gov',
    'time.nist.gov',
    'utcnist.colorado.edu',
    'utcnist2.colorado.edu',
    'ntp1.stratum2.ru',
    'ntp2.stratum2.ru',
    'ntp3.stratum2.ru',
    'ntp4.stratum2.ru',
    'tick.usask.ca',
    'tock.usask.ca',
    'ntp.nict.jp',


);

# flags to send to pscheduler. here we're setting the window to 128M
#my $pscheduler_flags = '-w 128M';

# currently we're hard-coded to throughput but should make this more flexible
my $pscheduler = '/usr/bin/pscheduler task throughput ';
my $ntp = '/usr/bin/ping -c 5';
my $ntpdate = '/sbin/ntpdate -q';
#my $source  = $hosts[0];
#my $destination = $hosts[1];

my @good = ();
my @bad = ();

foreach my $host (@hosts_new_test) {

    my $command = "$ntp $host";
    #$command .= $pscheduler_flags;

    warn "Command: " . $command . "\n";
    my $output = `$command`;
    warn "Output:\n$output\n";

    my $ntp_command = "$ntpdate $host";

    warn "ntpCommand: " . $ntp_command . "\n";
    my $ntp_output = `$ntp_command`;
    #my $ntp_output = system($ntp_command);
    warn "error val: " . $? . "\n";
    warn "ntpOutput:\n$ntp_output\n";
    if ( $? == 0 ) {
        warn "NTPGOOD\t$host\n";
        push @good, $host;
    } else {
        warn "NTPBAD\t$host\n";
        push @bad, $host;
    }
    warn "==GOOD hosts==\n" . join "\n", @good;
    warn "\n";
    warn "==BAD hosts==\n" . join "\n", @bad;
    warn "\n";


}

print "==GOOD hosts==\n" . join "\n", @good;
print "\n";
print "==BAD hosts==\n" . join "\n", @bad;
print "\n";

