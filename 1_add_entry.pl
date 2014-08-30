#!/usr/bin/perl -w
#########################
# Filename: 1_add_entry.pl
# Purpose:  This script will be used to add
#           an entry to the information.txt
#           file. It may be called from the
#           0_master_file.pl file.
# Author: Haydon Murdoch / hgm3
# Date started: 11/11/2013
#########################

sub write_log { # write the action to the logfile
	# including the name of the user added
	open LOG_FH, ">>logfile.txt";
	system("perl .get_date_time.pl >> logfile.txt"); # obtains current date and time
	$action = "\tUser \"$username_to_add\" was added to file\n\n";
	print LOG_FH "$action";
	close LOG_FH;

	print "Action has been logged in logfile.txt\n\n";
}

sub clear_screen { # clear the screen
	system("clear");
}

sub print_banner { # print "ADD USER" at the top of the screen
	print "      .o.       oooooooooo.   oooooooooo.\n";
	print "     .888.      `888'   `Y8b  `888'   `Y8b\n";
	print "    .8\"888.      888      888  888      888\n";
	print "   .8' `888.     888      888  888      888\n";
	print "  .88ooo8888.    888      888  888      888\n";
	print " .8'     `888.   888     d88'  888     d88'\n";
	print "o88o     o8888o o888bood8P'   o888bood8P'\n";
	print "\n";
	print "ooooo     ooo  .oooooo..o oooooooooooo ooooooooo.\n";
	print "`888'     `8' d8P'    `Y8 `888'     `8 `888   `Y88.\n";
	print " 888       8  Y88bo.       888          888   .d88'\n";
	print " 888       8   `\"Y8888o.   888oooo8     888ooo88P'\n";
	print " 888       8       `\"Y88b  888    \"     888`88b.\n";
	print " `88.    .8'  oo     .d8P  888       o  888  `88b.\n";
	print "   `YbodP'    8\"\"88888P'  o888ooooood8 o888o  o888o\n";
	print "\n"
}

sub greet_adding_user { # greet the user
	print "Hi there!\n";
	print "With this script you are able to\n";
	print "add a user into the system!\n";
	print "\n";
	print "   (Please note: the user must be a\n";
	print "   current member of the system (i.e.\n";
	print "   they exist in the /etc/passwd file))\n";
	print "\n";
	print "   (Note: you can exit this script at\n";
	print "   any point by hitting ^C. However,\n";
	print "   none of the information stored up\n";
	print "   to that point will be stored)\n";
	print "\n";
}

sub exit {
	print "Exit now?\n";
	$exit_choice = <STDIN>;
	chomp $exit_choice;
}

sub obtain_username { # obtain the username of the person to add
	print "Please enter the username:\t";
	$username_to_add = <STDIN>;
	chomp $username_to_add;
	&check_passwd_for_user;
}

#sub read_users {
#	open USERS_FH, "/etc/passwd";
#	$users_line = "";
#	while ($users_line = <USERS_FH>) {
#		@users = ($users_line =~ m/^.*:/);
#		print $users[0];
#	}
#	close USERS_FH;
#}
#
#sub print_users {
#	foreach $user (@users) {
#		print "$user\n";
#	}
#}

sub check_passwd_for_user {
	# check that the username supplied exists in /etc/passwd file
	# print "\tTESTING: \"$username_to_add\"\n";
	open ETC_PASSWD_FH, "/etc/passwd";
	$etc_passwd_linereader = "";
	$passwd_found = 1; # initialise a "found" variable
	while ($etc_passwd_linereader = <ETC_PASSWD_FH>) {
		if ($etc_passwd_linereader =~ /^$username_to_add:/) { #	if found...
			print "\tUser \"$username_to_add\" found",
			" to exist in /etc/passwd file!\n\n"; # inform the user
			$passwd_found = 0; # alter "found" variable
			&check_for_duplicates; # call duplicate-checking subroutine
			#&obtain_address;
		} else {
			next; # if that line doesn't match the
			# username, go to the next line
		}
	}

	if ($passwd_found == 1) { # if found var is found to be unchanged
		print "\tSorry, user \"$username_to_add\"";
		print " was not found in /etc/passwd file\n\n";
		&obtain_username; # obtain a different username
	}

	close ETC_PASSWD_FH;
}

sub check_for_duplicates {
	# Check that the username does
	# not already exist in the file.
	# In this case, matching is bad.
	print "\tChecking for duplicates in information file...\n";
	open DUP_FH, "information.txt";
	$dup_line = "";
	$duplicate_found = 1; # initialise a "found" variable
	while ($dup_line = <DUP_FH>) {
		if ($dup_line =~ m/^$username_to_add:/) {
			print "\tUser \"$username_to_add\"";
			print " exists in information file!\n\n";
			$duplicate_found = 0;
			&obtain_username; # obtain a different username
		} else {
			next; # if that line doesn't match the
			# username, go to the next line
		}
	}

	if ($duplicate_found == 1) { # if not found, this is good!
		print "\tAll checks passed!\n\n"; # inform the user!
		&obtain_address; # proceed with adding info!
	}
}

###############################################################################
# CHECKING EACH ELEMENT OF THE INFO TO ADD INDIVIDUALLY                       #
# Each element to add has two subroutines related to it                       #
#  - One to obtain it                                                         #
#  - Another to check it (regex)                                              #
###############################################################################
sub obtain_address {
	print "Please enter the address:\t";
	$address_to_add = <STDIN>;
	chomp $address_to_add;
	&check_address;

}

sub check_address {
	if ($address_to_add eq "") { # check for empty string
		print "\tUnable to insert address\n";
		print "\tas string contains nothing\n";
		&obtain_address; # try again
	} elsif ($address_to_add =~ /:/) { # check for colons
		print "\tUnable to insert address\n";
		print "\tas string contains :\n";
		&obtain_address; # try again
	} else {
		&obtain_email; # go to next stage
	}
}

sub obtain_email {
	print "Please enter the email address:\t";
	$email_to_add = <STDIN>;
	chomp $email_to_add;
	&check_email;
}

sub check_email {
	if ($email_to_add !~ /.+@.+/) { # [anything]@[anything]
		print "\tInvalid email format\n";
		print "\tRequires [something]@[something]\n";
		&obtain_email; # try again
	} else {
		&obtain_telephone; # go to next stage
	}
}

sub obtain_telephone {
	print "Please enter the telephone\n";
	print " extension number:\t\t";
	$telephone_to_add = <STDIN>;
	chomp $telephone_to_add;
	&check_telephone;
}

sub check_telephone {
	#if ($telephone_to_add =~ /\d{0,3}/) {
	#	print "\tLess than four digits!\n";
	#	print "\tPlease try again\n";
	#	&obtain_telephone;
	#} elsif ($telephone_to_add =~ /\d{5,}/) {
	#	print "\tMore than four digits!\n";
	#	print "\tPlease try again\n";
	#} else {
	#	&obtain_m_user;
	#}
	if ($telephone_to_add =~ /\d{5,}/) { # if too many...
		print "\tToo many!\n";
		print "Requires 4 digits exactly\n";
		&obtain_telephone; # try again
	} elsif ($telephone_to_add =~ /\d{4}/) { # perfect
		&obtain_m_user; # go to next stage
	} else { # anything else
		print "\tInvalid format!\n";
		print "\tRequires exactly four digits\n";
		&obtain_telephone; # try again
	}
}

sub obtain_m_user {
	print "Please enter the username\n";
	print " of the user's manager:\t\t";
	$m_username_to_add = <STDIN>;
	chomp $m_username_to_add;
	&check_m_user;
}

sub check_m_user {
	print "\t(No checks on this element!)\n"; # no checks yet
	&obtain_start; # go to next stage
}

sub obtain_start {
	print "Please enter the start\n";
	print " date for this user:\t\t";
	$start_date_to_add = <STDIN>;
	chomp $start_date_to_add;
	&check_start;
}

sub check_start {
	if ($start_date_to_add =~ /\d{3,}\/\d{3,}\/\d{5,}/) { # ugh
		print "\tInvalid date format\n";
		print "\tDD/MM/YYYY required\n";
		&obtain_start; # try again
	} elsif ($start_date_to_add =~ /\d{2}\/\d{2}\/\d{4}/) { # perfect
		print "\tExact date match!\n";
		&obtain_end; # go to next stage
		#&check_start_values;
	} else { # anything else
		print "\tInvalid date format\n";
		print "\tDD/MM/YYYY required\n";
		&obtain_start; # try again
	}
}

#sub check_start_values {
#	$min_days   = 1;
#	$max_days   = 31;
#	$min_months = 1;
#	$max_months = 12;
#	$min_years  = 1950;
#	$max_years  = 2013;
#	@start_values = split ('/', $start_date_to_add);
#	if (($start_values[0] < $min_days) or ($start_values[0] < $max_days)) {
#		if (($start_values[1] < $min_months) or ($start_values[1] > $min_months)) {
#			if (($start_values[2] < $min_years) or ($start_values[2] > $max_years) {
#				&obtain_end;
#			} else {
#				print "Year is wrong\n";
#		} else {
#			print "Month is wrong\n";
#	} else {
#		print "Day is wrong\n";
#	}
#}

sub obtain_end {
	print "Please enter the finish\n";
	print " date for this user:\t\t";
	$end_date_to_add = <STDIN>;
	chomp $end_date_to_add;
	&check_end;
}

sub check_end {
	if ($end_date_to_add =~ /\d{3,}\/\d{3,}\/\d{5,}/) { # ugh
		print "\tInvalid date format\n";
		print "\tDD/MM/YYYY required\n";
		&obtain_end; # try again
	} elsif ($end_date_to_add =~ /\d{2}\/\d{2}\/\d{4}/) { # perfect
		print "\tExact date match!\n";
		&create_join; # go to next stage
		#&check_start_values;
	} else {
		print "\tInvalid date format\n";
		print "\tDD/MM/YYYY required\n";
		&obtain_end; # try again
	}
}

###############################################################################
# END OF CHECKS                                                               #
###############################################################################

sub create_join { # take all details entered and join together
	# delimiter is a colon (:)
	$info_to_add = join(':',
		$username_to_add,
		$address_to_add,
		$email_to_add,
		$telephone_to_add,
		$m_username_to_add,
		$start_date_to_add,
		$end_date_to_add
	);

	print "\n";
	print "The join is:\n\"$info_to_add\"\n\n"; # inform the user of info to be added
	print "Data will now be written to file\n";
	&insert_data_to_file;
}

sub insert_data_to_file { # append info to add to end of info file
	open ADD_ENTRY_FH, ">>information.txt";
	print ADD_ENTRY_FH "$info_to_add\n";
	close ADD_ENTRY_FH;

	&write_log; # write to the log
}

sub sort_by_start_date { # don't think this works yet...
	# it is not called anywhere in the script
	# it simply exists here for evaluation purposes
	open DATE_SORT_FH, "information.txt";
	$date_line_reader = "";
	while ($date_line_reader = <DATE_SORT_FH>) {
		@element = split(/:/, $date_line_reader);
		print "Start date is: $element[5]\n";
	}

}

&clear_screen;         # clear the screen
&print_banner;         # print the panner
&greet_adding_user;    # greets the user and instructs them on what to do next
&obtain_username;      # asks the user a series of questions to gain info
#&create_join;         # takes the info it receives and converts it into a single string
                         # it is now only called when addition confirmation is obtained
#&insert_data_to_file; # inserts this joined string into the end of the information.txt file
                         # it is now only called when addition confirmation is obtained
