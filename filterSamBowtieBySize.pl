#!/usr/bin/perl
########################################################################
#########################################################################
### Copyright 2021 Universidade Federal de Minas Gerais
### Author: Eric Aguiar
### E-mail: ericgdp@gmail.com
### This script is a free software: you can redistribute it and/or modify
### it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.
###
### template.pl is distributed in the hope that it will be useful,but WITHOUT ANY WARRANTY;
### without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
### See the GNU General Public License for more details.
###
### You should have received a copy of the GNU General Public License along with template.pl (file: COPYING).
### If not, see <http://www.gnu.org/licenses/>.
###
#########################################################################
#########################################################################

use Getopt::Long;
use Bio::SeqIO;

my $usage = "

$0 -i <input sam file> -si <initial size> -se <end size> -o <output>
$0 -h

-i <input sam file>     : Input sam file
-si <initial size>      : Initial size of the sequence
-se <end size>          : End size of the sequence
-o <output>             : output file
-h                      : Help message

";

$| = 1;     # forces immediate prints into files rather than the buffer.

my $input;
my $sizeI;
my $sizeE;
my $out;

GetOptions ("i=s" => \$input,
        "si=s" => \$sizeI,
        "se=s" => \$sizeE,
        "o=s" => \$out,
        "h!" => \$help);

if ($help) {
        die $usage;
}

if (not(defined($input))) {
        die "\nGive an input file name",$usage;
}

if ( (not(defined($sizeE)) or not(defined($sizeI))) and ($sizeI > $sizeE) and ($sizeI != 0 and $sizeE != 0) ) {
        die "\nGive initial size and end size valid",$usage;
}




open(S,"<$input");
open(O,">$out");


while(<S>){
	/\t(\d+)M.+\t/;	
	if (/^@.+/){
		print O  $_;
	}
	elsif($1 ge $sizeI  and $1 le $sizeE){
		print  O $_;
	}
}

close(S);
close(O);


