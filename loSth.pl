#!/usr/bin/perl
#use warnings;
use strict;

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

$pre{'+'}='my $n1=spop; my $n2=spop; spush $n1 + $n2;';
$pre{'p'}='print spop';
$hash{'inc'}="1 +";
$hash{'loop'}="loop";
while(<>){
	seval $_	

}



sub isnum {
	my $value = shift;
	return $value =~ /^[0-9]/;
}

sub interpret {
	my $token = shift;
	print "DBG interpret $token\n" if $DBG;
	if (!isnum $token){
		execute $token;
	}else{
		spush $token;
	}
}

sub spush {
	my $value = shift;
	print "DBG spush $value\n";
	push @STACK, $value;
}

sub spop {
	return pop @STACK;	
}

sub execute {
	my $name = shift;
	if ( $hash{$name} ne '' ){
		print "DBG seval $name $hash{$name}\n" if $DBG;
		seval $hash{$name};
	}else{	
		print "DBG eval $name $pre{$name}\n" if $DBG;
		eval $pre{$name};
	}
}

sub seval {
	my $code = shift;

	my @tokens = split /\s+/, $code;
	print "DBG tokens ",join ":",@tokens,"\n" if $DBG;
	foreach my $token (@tokens){
		interpret $token;
	}
}
