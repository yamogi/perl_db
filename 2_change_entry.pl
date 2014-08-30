#!/usr/bin/perl -w
#########################
# Filename: 2_change_entry.pl
# Purpose:  This script may be used to
#           alter the information
#           contained in one of the
#           entries of the information
#           file. It may be called from
#           the 0_master_file.pl file.
# Author: Haydon Murdoch / hgm3
# Date started: 11/11/2013
#########################

sub clear_screen { # clear the screen
	system("clear");
}

sub print_banner { # print "MODIFY USER"
	print "ooo        ooooo   .oooooo.   oooooooooo.   ooooo oooooooooooo oooooo   oooo\n";
	print "`88.       .888'  d8P'  `Y8b  `888'   `Y8b  `888' `888'     `8  `888.   .8'\n";
	print " 888b     d'888  888      888  888      888  888   888           `888. .8'\n";
	print " 8 Y88. .P  888  888      888  888      888  888   888oooo8       `888.8'\n";
	print " 8  `888'   888  888      888  888      888  888   888    \"        `888'\n";
	print " 8    Y     888  `88b    d88'  888     d88'  888   888              888\n";
	print "o8o        o888o  `Y8bood8P'  o888bood8P'   o888o o888o            o888o\n";
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
	print "Hey there!\n";
	print "This script will allow you to modify\n";
	print "any user which exists in the info file.\n\n";
	print "Two options will be availale to you\n";
	print "once you have decided on a user to edit\n";
	print "\t- Editing the entire record relating to that user\n";
	print "\t- Editing a particular field for that user\n\n";
}

sub modify_which_user { # ask the user who they want to modify
	print "Please enter the user you wish to modify\n\t-> ";
	$user_to_modify = <STDIN>;
	chomp $user_to_modify;

	&check_user_exists; # check if the user exists in the file...
}

sub check_user_exists {
	open EXISTS_FH, "information.txt";
	$line_reader = "";

	$found = 1; # initiliase a found variable

	while ($line_reader = <EXISTS_FH>) {
		if ($line_reader =~ m/^$user_to_modify:/) {
			print "User successfully identified!\n\n";
			$found = 0; # change found variable
			&split_line; # split the line
			&print_current_user; # ...
			&modify_user_choice; # ...
		} else { # if not found on that line...
			next; # go the next line
		}
	}

	if ($found == 1) { # if found variable is unchanged
		print "User not found to exist\n\n"; # inform the user
		&modify_which_user; # ask them to enter another username
	}
}

sub split_line {
	@formatted_info = split /:/, $line_reader; # split the line which contains the
}	                                           # username by the colon delimiter


sub get_choice { # ascertain whether the user wishes to continue with modification
	$choice = <STDIN>;
	chomp $choice;
}

sub print_current_user {
	$current_user = $formatted_info[0];
	print "The user to be edited is: \"$current_user\"\n";
}

sub modify_user_choice {
	print "Do you wish to continue with\n";
	print "modification? y/n/p to print\n";
	&get_choice;

	if ($choice eq "y") { # if yes, begin modification
		print "\nUser will now be modified!\n\n";
		&modify_user_y;
	} elsif ($choice eq "n") { # if no, exit script
		die "\nNo modification was made\n\n";
	} elsif ($choice eq "p") { # if print, print the line
		print "\n\t$line_reader\n";
		&modify_user_choice; # then ask again
	} else { # anything else, try again
		print "\nInvalid input: y/n required\n\n";
		&modify_user_choice;
	}
}

sub modify_user_y {
	print "Modify all user attributes?\n";
	print "Or only modify some values?\n";
	$modify_1_or_2 = 0;
	while ($modify_1_or_2 != 1 && $modify_1_or_2 != 2) {
		print "\t1. Alter all values\n";
		print "\t2. Alter specific values\n\t";
		$modify_1_or_2 = <STDIN>;
		chomp $modify_1_or_2;

		if ($modify_1_or_2 == 1) {
			&clear_screen;
			&modify_user_FULL;
		} elsif ($modify_1_or_2 == 2) {
			&clear_screen;
			&modify_user_PARTIAL;
		}
	}
}

sub modify_user_FULL { # full modification subroutine
	print "Please enter a new username\n";
	$new_user = <STDIN>;
	chomp $new_user;
	$formatted_info[0] = $new_user;

	print "Please enter a new address\n";
	$new_address = <STDIN>;
	chomp $new_address;
	$formatted_info[1] = $new_address;

	print "Please enter a new email\n";
	$new_email = <STDIN>;
	chomp $new_email;
	$formatted_info[2] = $new_email;

	print "Please enter a new extension number\n";
	$new_extension = <STDIN>;
	chomp $new_extension;
	$formatted_info[3] = $new_extension;

	print "Please enter a new manager username\n";
	$new_m_user = <STDIN>;
	$formatted_info[4] = $new_user;

	print "Please enter a new start address\n";
	$new_start = <STDIN>;
	chomp $new_start;
	$formatted_info[5] = $new_start;

	print "Please enter a new end address\n";
	$new_end = <STDIN>;
	chomp $new_end;
	$formatted_info[6] = $new_end;

	$new_info = join (':', @formatted_info);
	print "The new info is:\n\t$new_info\n";

	#	system("perl 1_add_entry.pl");

	&modify_info_confirm;
}

sub modify_user_PARTIAL { # partial modification subroutine (not working)
	print "PARTIAL MODIFICATION\n";
	print "UNDER CONSTRUCTION\n\n";

#	print "Edit username?\n";
#	$edit_user = <STDIN>;
#	chomp $edit_user;
#	if ($edit_user eq "y") {
#		&edit_user;
#	}
	#
#	print "Edit address?\n";
#	$edit_address = <STDIN<
	#
	$new_info = $line_reader;
	die "Program will now exit\n";
	#&modify_info_confirm;
}

sub modify_info_confirm {
	print "Modify the user with these values? y/n\n";
	$modify_confirm = <STDIN>;
	chomp $modify_confirm;

	if ($modify_confirm eq "y") {
		print "Info will be modified\n";
		&delete_line; # remove the old line from the file
		&insert_line; # insert the new line into the file
	} elsif ($modify_confirm eq "n") {
		&quit_choice; # ask if user is sure they wish to exit
	} else {
		print "Invalid input! y/n required\n\n";
		&modify_info_confirm;
	}
}

sub delete_line {
	# print every line to a .tempfile.txt UNLESS
	# the username matches the one to delete
	open(INFILE, "<information.txt") or die "error with infile\n";
	open(OUTFILE, ">.tempfile.txt") or die "error with outfile\n";

	$line_reader = "";

	while ($line_reader = <INFILE>) {
		print OUTFILE "$line_reader" unless $line_reader =~ m/^$user_to_modify:/;
	}

	close INFILE;
	close OUTFILE;

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

sub insert_line {
	open LAST_FH, "information.txt";
	@lines = <LAST_FH>;
	close LAST_FH;
	$last_line = pop (@lines);

	open APPEND_FH, ">>information.txt";
	if ($last_line eq "") {
		print APPEND_FH "$new_info\n";
	} else {
		print APPEND_FH "$new_info\n";
	}
}

sub quit_choice {
	print "Quit without\n";
	print "any changes? y/n\n";
	print "Choosing \"n\" will\n";
	print "ask for a new user to edit\n\t";

	$decision = <STDIN>;
	chomp $decision;

	if ($decision eq "y") {
		die "Program will now exit\n";
	} elsif ($decision eq "n") {
		&clear_screen;
		&print_banner;
		&modify_which_user;
	} else {
		print "Invalid input!\n";
		&quit_choice;
	}
}

&clear_screen;
&print_banner;
&greet_user;
&modify_which_user;
