#!/usr/bin/perl -w
#########################
# Filename: 3_delete_entry.pl
# Purpose:  This script allows the user to
#           remove a particular entry from
#           the file information.txt. To
#           do this, the file must check
#           that the entry to be deleted
#           is unique. It may be called
#           from the 0_master_file.pl file.
# Author: Haydon Murdoch / hgm3
# Date started: 11/11/2013
#########################

sub write_log { # write to the log file WHO was deleted
	open LOG_FH, ">>logfile.txt";
	system("perl .get_date_time.pl >> logfile.txt");
	$action = "\tUser \"$user_to_delete\" was deleted from file\n\n";
	print LOG_FH "$action";
	close LOG_FH;

	print "Action has been logged in logfile.txt\n\n";
}

sub clear_screen { # clear the screen
	system("clear");
}

sub print_banner { # print DEL USER
	print "oooooooooo.   oooooooooooo ooooo\n";
	print "`888'   `Y8b  `888'     `8 `888'\n";
	print " 888      888  888          888\n";
	print " 888      888  888oooo8     888\n";
	print " 888      888  888    \"     888\n";
	print " 888     d88'  888       o  888       o\n";
	print "o888bood8P'   o888ooooood8 o888ooooood8\n";
	print "\n";
	print "ooooo     ooo  .oooooo..o oooooooooooo ooooooooo.\n";
	print "`888'     `8' d8P'    `Y8 `888'     `8 `888   `Y88.\n";
	print " 888       8  Y88bo.       888          888   .d88'\n";
	print " 888       8   `\"Y8888o.   888oooo8     888ooo88P'\n";
	print " 888       8       `\"Y88b  888    \"     888`88b.\n";
	print " `88.    .8'  oo     .d8P  888       o  888  `88b.\n";
	print "   `YbodP'    8\"\"88888P'  o888ooooood8 o888o  o888o\n";
	print "\n\n";
}

sub greet_user { # greet the user
	print "Hi there!\n";
	print "With this script you are able to\n";
	print "delete a user from the information\n";
	print "file. Confirmation will be required\n";
	print "before deletion takes place.\n\n";
}

sub obtain_user_to_delete { # ask who they wish to delete
	print "Please enter the username of the\n";
	print "you wish to remove from the system: ";

	$user_to_delete = <STDIN>;
	chomp $user_to_delete;
}

sub read_file_to_array {
	# trying to split into lines array while reading information.txt
	open FILE, "information.txt";
	@file_contents = <FILE>;
	close FILE;
}

sub find_user {
	foreach $line_to_check (@file_contents) {
		if ($line_to_check =~ m/^$user_to_delete:/) {
			print "\tUser has been found!\n";
			print "\tAre you sure you wish\n";
			print "\tto delete this user?\n";
			print "\t--- y/n/p to print ---\n";

			$delete_confirm = <STDIN>;
			chomp $delete_confirm;

			if ($delete_confirm eq "y") {
				$line_to_check =~ s/^.*$//;
				&print_to_temp_file;
				&print_to_original_file;
				&write_log;
			} elsif ($delete_confirm eq "n") {
				print "k\n";
			} elsif ($delete_confirm eq "p") {
				# print the line for convenience
				print "\"$line_to_check\"\n";
			} else {
				print "Invalid input! y/n/p required\n";
			}
		}
	}

}

sub print_to_temp_file {
	# print every line to a .tempfile.txt UNLESS
	# the username matches the one to delete
	open(INFILE, "<information.txt") or die "error with infile\n";
	open(OUTFILE, ">.tempfile.txt") or die "error with outfile\n";

	$line_reader = "";

	while ($line_reader = <INFILE>) {
		print OUTFILE "$line_reader" unless $line_reader =~
		m/^$user_to_delete:/;
	}

	close INFILE;
	close OUTFILE;
}

sub print_to_original_file {
	# overwrite the original file with every line
	# from .tempfile (that is, removing the user)
	open(INFILE, "<.tempfile.txt") or die "error with infile\n";
	open(OUTFILE, ">information.txt") or die "error with outfile\n";

	$line_reader = "";

	while ($line_reader = <INFILE>) {
		print OUTFILE "$line_reader"
	}

	close INFILE;
	close OUTFILE;
}

&clear_screen;
&print_banner;
&greet_user;
&obtain_user_to_delete;
&read_file_to_array;
&find_user;
