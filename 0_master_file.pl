#!/usr/bin/perl
#########################
# Filename: 0_master_file.pl
# Purpose:  This file acts as the "master" file,
#           allowing for a menu system where the
#           user can choose what they want to do
#           with the information file.
# Author:   Haydon Murdoch / hgm3
# Date started: 11/11/2013
#########################

#sub write_log {
#	open LOG_FH, ">>logfile.txt";
#	system("perl .get_date_time.pl >> logfile.txt");
#	print LOG_FH "$something";
#	close LOG_FH;
#
#	print "Action has been logged in logfile.txt\n\n";
#}

sub clear_screen { # subroutine to clear the screen
	system("clear");
}

sub print_banner { # subroutine to print a banner
	print "ooo        ooooo oooooooooooo ooooo      ooo ooooo     ooo\n";
	print "`88.       .888' `888'     `8 `888b.     `8' `888'     `8'\n";
	print " 888b     d'888   888          8 `88b.    8   888       8\n";
	print " 8 Y88. .P  888   888oooo8     8   `88b.  8   888       8\n";
	print " 8  `888'   888   888    \"     8     `88b.8   888       8\n";
	print " 8    Y     888   888       o  8       `888   `88.    .8'\n";
	print "o8o        o888o o888ooooood8 o8o        `8     `YbodP'\n";
	print "\n";
}

sub greet_user { # subroutine to greet the user
#	print "<-<-<-<-<-<-<-<-<-<- INITIATING MENU SEQUENCE ->->->->->->->->->->\n";
	print "Hey there, user!\n";
	print "  Welcome to the menu system!\n";
	print "    From here, you are able to choose what\n";
	print "    you wish to do with the information file!\n";
	print "      Please select an option to continue!\n";
}

sub print_menu { # subroutine to print the menu
	print "\n";
	print "\t1. Add an entry to the file\n";
	print "\t2. Modify an entry in the file\n";
	print "\t3. Delete an entry in the file\n";
	print "\t4. Return specific info from a\n";
	print "\t    user stored in the file\n";
	print "\t5. Display all entries in the file\n";
	print "\n";
	print "\t\tEnter \"quit\" to exit the program.\n";
	print "\t\tEnter \"log\" to view the logfile.\n";
	print "\n";
}

sub obtain_user_entry { # subroutine to obtain user entry
	print "Enter your choice here: ";
	$user_choice = <STDIN>;
	chomp $user_choice;
}

sub return_to_menu {
	print "\nReturn to main menu? y/n\n";
	$return = <STDIN>;
	chomp $return;

	# read return value and act accordingly
	if ($return eq "y") {
		$user_choice = -1; # reinitalise variable
		&print_banner;
		&print_menu;
	} elsif ($return eq "n") {
		#&clear_screen;
		#die "Program will now exit\n";
		#system("exit");
		p
		&clear_screen;
		&exit_program;
	} else {
		print "Invalid input\n";
		print "\"y\" or \"n\" required\n";
		print "\n";
		&return_to_menu;
	}

}

sub wait_for_key_press { # wait for ENTER to be pressed
	print "Please press ENTER to continue\n";
	<STDIN>;
}

sub act_on_user_entry { # subroutine to manage where to go from here

	#print "\t(The subroutine has been called!)\n";
	print "\tYou chose option: $user_choice";

	if ($user_choice == 1) {		# add entry
		print ", adding a user\n\n";
		&wait_for_key_press;
		&clear_screen;
		system("perl 1_add_entry.pl");
		&return_to_menu;
	} elsif ($user_choice == 2) {		# modify entry
		print ", modifying a user\n\n";
		&wait_for_key_press;
		&clear_screen;
		system("perl 2_change_entry.pl");
		&return_to_menu;
	} elsif ($user_choice == 3) {		# delete entry
		print ", deleting a user\n\n";
		&wait_for_key_press;
		&clear_screen;
		system("perl 3_delete_entry.pl");
		&return_to_menu;
	} elsif ($user_choice == 4) {		# return info
		print ", returning info on a specific user\n\n";
		&wait_for_key_press;
		&clear_screen;
		system("perl 4_return_info.pl");
		&return_to_menu;
	} elsif ($user_choice == 5) {		# display all
		print ", displaying info on all users\n\n";
		&wait_for_key_press;
		&clear_screen;
		system("perl 5_display_all.pl");
		&return_to_menu;
	} elsif ($user_choice =~ /^quit$/i) {	# exit the program
		next;
		#&clear_screen;
		#die "\tThe program will now exit\n\n";
		#system("exit");
	} elsif ($user_choice =~ /^log$/i) {	# view the logfile
		print ", viewing the log file\n\n";
		&wait_for_key_press;
		&clear_screen;
		&view_log;
		&return_to_menu;
	} elsif ($user_choice == -1) {		# -1 if returning to this menu
		&clear_screen;			# through &return_menu
		&print_banner;
		&print_menu;
		&obtain_user_entry;
	} else {				# if all else fails...
		print "[INVALID INPUT]!\n";
		print "\tPlease try again!\n\n";
		&obtain_user_entry;
	}

}

sub view_log { # subroutine to read the log file
	open LOG_FH, "logfile.txt";
	$log_reader = "";
	while ($log_reader = <LOG_FH>) {
		print $log_reader;
	}
}

sub exit_program { # subroutine to let the user know the program is finsihed
	&clear_screen;

	print "oooooooooo.  oooooo   oooo oooooooooooo .o.\n";
	print "`888'   `Y8b  `888.   .8'  `888'     `8 888\n";
	print " 888     888   `888. .8'    888         888\n";
	print " 888oooo888'    `888.8'     888oooo8    Y8P\n";
	print " 888    `88b     `888'      888    \"    `8'\n";
	print " 888    .88P      888       888       o .o.\n";
	print "o888bood8P'      o888o     o888ooooood8 Y8P\n";

	die "\n\n\tThank you for using this program! :-)\n\n\n";
}

&clear_screen;				# clear the screen
&print_banner;				# print "MENU"
&greet_user;				# greet the user
&print_menu;				# print the menu
&obtain_user_entry;			# understand what the user wishes to do
while ($user_choice !~ /^quit$/i) {	# until the user wishes to exit the program...
	&act_on_user_entry;		# act upon their decision
}					# after everything...
&exit_program;				# cleanly exit the program
# this subroutine either happens automatically...
# or is called after user enters "n" at &return_to_menu
