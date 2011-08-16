#!/usr/bin/perl
#use warnings;

our @STACK;
our %hash;
our %pre;

sub isnum;
sub interpret;
sub spush;
sub spop;
sub execute;
sub seval;

$DBG++;

$pre{'+'}='$n1=spop; $n2=spop; spush $n1 + $n2;';
$pre{'p'}='print spop';
$hash{'inc'}="1 +";
while(<>){
	seval $_	

}



sub isnum {
	$value = shift;
	return $value =~ /^[0-9]/;
}

sub interpret {
	$token = shift;
	if (!isnum $token){
		execute $token;
	}else{
		spush $token;
	}
}

sub spush {
	$value = shift;
	push @STACK, $value;
}

sub spop {
	return pop @STACK;	
}

sub execute {
	my $name = shift;
	if ( $hash{$name} ne '' ){
		print "SEVAL" if $DBG;
		seval $hash{$name};
	}else{	
		print "\nEVAL $name $pre{$name}\n" if $DBG;
		eval $pre{$name};
	}
}

sub seval {
	my $code = shift;

	@tokens = split /\s+/, $code;
	foreach $token (@tokens){
		interpret $token;
	}
}
