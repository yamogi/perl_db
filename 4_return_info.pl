#!/usr/bin/perl -w
#########################
# Filename: 4_return_info.pl
# Purpose:  This script allows the user to
#           specify a username, and then
#           the program will return certain
#           info from the information.txt
#           file. The output will be
#           formatted appropriately. It may
#           be called from the
#           0_master_file.pl file.
# Author: Haydon Murdoch / hgm3
# Date started: 11/11/2013
#########################

sub clear_screen { # clear the screen
	system("clear");
}

sub print_banner { # print GET INFO
	print "  .oooooo.    oooooooooooo ooooooooooooo\n";
	print " d8P'  `Y8b   `888'     `8 8'   888   `8\n";
	print "888            888              888\n";
	print "888            888oooo8         888\n";
	print "888     ooooo  888    \"         888\n";
	print "`88.    .88'   888       o      888\n";
	print " `Y8bood8P'   o888ooooood8     o888o\n";
	print "\n";
	print "ooooo ooooo      ooo oooooooooooo   .oooooo.\n";
	print "`888' `888b.     `8' `888'     `8  d8P'  `Y8b\n";
	print " 888   8 `88b.    8   888         888      888\n";
	print " 888   8   `88b.  8   888oooo8    888      888\n";
	print " 888   8     `88b.8   888    \"    888      888\n";
	print " 888   8       `888   888         `88b    d88'\n";
	print "o888o o8o        `8  o888o         `Y8bood8P'\n";
	print "\n\n";
}

sub greet_user { # greet the user
	print "Hey there\n";
	print "With this script you are able to return full\n";
	print "or partial information on a specific user that\n";
	print "resides within the information.txt file\n\n";
}

sub print_whose_info {
	print "Which user would you like information on?\n\t-> ";
	$which_user = <STDIN>;
	chomp $which_user;
	&read_file_to_array;
	&find_user;
}

sub read_file_to_array {
	open FILE, "information.txt";
	@file_contents = <FILE>;
	close FILE;
}

sub find_user {
	$found = 1;

	foreach $line_to_check (@file_contents) {
		if ($line_to_check =~ m/^$which_user:/) {
			print "User has been found!\n";
			$found = 0;
			print "Now, let's decide what\n";
			print "information to display\n\n";
			&what_info;
		}
	}

	if ($found == 1) {
		print "User not found in file\n";
		&print_whose_info;
	}
}

sub what_info {
	print "Print username? y/n\n\t-> ";
	$print_user = <STDIN>;
	chomp $print_user;
	&print_user_check;

	print "Print address? y/n\n\t-> ";
	$print_address = <STDIN>;
	chomp $print_address;
	&print_address_check;

	print "Print email? y/n\n\t-> ";
	$print_email = <STDIN>;
	chomp $print_email;
	&print_email_check;

	print "Print tele extension? y/n\n\t-> ";
	$print_extension = <STDIN>;
	chomp $print_extension;
	&print_extension_check;

	print "Print manager's username? y/n\n\t-> ";
	$print_m_user = <STDIN>;
	chomp $print_m_user;
	&print_m_user_check;

	print "Print start date? y/n\n\t-> ";
	$print_start = <STDIN>;
	chomp $print_start;
	&print_start_check;

	print "Print end date? y/n\n\t-> ";
	$print_end = <STDIN>;
	chomp $print_end;
	&print_end_check;

	&split_line;
	&print_desired_info;
}

########## CHECKING INPUT FOR EACH CHOICE ##########
##########         VERY MESSY CODE        ##########
sub print_user_check {
	if ($print_user ne "y" && $print_user ne "n") {
		print "Invalid input\n";
		&what_info;
	}
}
sub print_address_check {
	if ($print_address ne "y" && $print_address ne "n") {
		print "Invalid input\n";
		&what_info;
	}
}
sub print_email_check {
	if ($print_email ne "y" && $print_email ne "n") {
		print "Invalid input\n";
		&what_info;
	}
}
sub print_extension_check {
	if ($print_extension ne "y" && $print_extension ne "n") {
		print "Invalid input\n";
		&what_info;
	}
}
sub print_m_user_check {
	if ($print_m_user ne "y" && $print_m_user ne "n") {
		print "Invalid input\n";
		&what_info;
	}
}
sub print_start_check {
	if ($print_start ne "y" && $print_start ne "n") {
		print "Invalid input\n";
		&what_info;
	}
}
sub print_end_check {
	if ($print_end ne "y" && $print_end ne "n") {
		print "Invalid input\n";
		&what_info;
	}
}
###################################################
###################################################

sub split_line {
	@info_split = split /:/, $line_to_check;
}


sub print_desired_info {
	print "\n"; # separate section from rest of output

	if ($print_user eq "y") {
		$username = $info_split[0];
		print "Username:\t\t$username\n";
	} elsif ($print_user eq "n") {
		print "|-------(Username was skipped)-------|\n";
	}

	if ($print_address eq "y") {
		$address = $info_split[1];
		print "Address:\t\t$address\n";
	} elsif ($print_address eq "n") {
		print "|--------(Address was skipped)-------|\n";
	}

	if ($print_email eq "y") {
		$email = $info_split[2];
		print "Email:\t\t\t$email\n";
	} elsif ($print_email eq "n") {
		print "|---------(Email was skipped)--------|\n";
	}

	if ($print_extension eq "y") {
		$extension = $info_split[3];
		print "Extension:\t\t$extension\n";
	} elsif ($print_extension eq "n") {
		print "|-------(Extension was skipped)------|\n";
	}

	if ($print_m_user eq "y") {
		$m_user = $info_split[4];
		print "Manager's username:\t$m_user\n";
	} elsif ($print_m_user eq "n") {
		print "|--(Manager's username was skipped)--|\n";
	}

	if ($print_start eq "y") {
		$start = $info_split[5];
		print "Start date:\t\t$start\n";
	} elsif ($print_start eq "n") {
		print "|------(Start date was skipped)------|\n";
	}

	if ($print_end eq "y") {
		$end = $info_split[6];
		print "End date:\t\t$end\n";
	} elsif ($print_end eq "n") {
		print "|-------(End date was skipped)-------|\n";
	}
}

&clear_screen;
&print_banner;
&greet_user;
&print_whose_info;
