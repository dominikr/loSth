#!/usr/bin/perl
#use warnings;
use strict;
use Term::ReadKey;

our @STACK;
our %hash;
our %pre;

sub isnum;
sub interpret;
sub spush;
sub spop;
sub execute;
sub seval;

our $DBG++;
sub DBG{
	my $msg = shift;
	print "DBG: $msg\n" if $DBG;
}

ReadMode 'cbreak';

$pre{'+'}='my $n1=spop; my $n2=spop; spush $n1 + $n2;';
$pre{'p'}='print spop';
$pre{'emit'}='print chr spop';
$pre{'key'}='spush ord ReadKey(0)';
$pre{'dup'}='my $n1=spop;spush $n1; spush $n1';
$hash{'inc'}="1 +";
$hash{'loop'}="loop";
$hash{'miau'}="key dup emit miau";

while(<>){
	seval $_	

}



sub isnum {
	my $value = shift;
	return $value =~ /^[0-9]/;
}

sub interpret {
	my $token = shift;
	DBG "interpret $token";
	if (!isnum $token){
		execute $token;
	}else{
		spush $token;
	}
}

sub spush {
	my $value = shift;
	DBG "spush $value";
	push @STACK, $value;
}

sub spop {
	return pop @STACK;	
}

sub execute {
	my $name = shift;
	if ( $hash{$name} ne '' ){
		DBG "seval $name $hash{$name}";
		seval $hash{$name};
	}else{	
		DBG "eval $name $pre{$name}";
		eval $pre{$name};
	}
}

sub seval {
	my $code = shift;

	my @tokens = split /\s+/, $code;
	DBG "tokens :".(join ":",@tokens).":";
	foreach my $token (@tokens){
		interpret $token;
	}
}
