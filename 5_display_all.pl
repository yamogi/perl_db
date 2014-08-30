#!/usr/bin/perl -w
#########################
# Filename: 5_display_all.pl
# Purpose:  This scripts opens the file
#           information.txt, formats each
#           line (splitting by the ":"
#           delimiter), and prints the#
#           formatted line for each user.
#           It may be called from the
#           0_maser_file.pl file.
# Author: Haydon Murdoch / hgm3
# Date started: 11/11/2013
#########################

sub clear_screen { # clear the screen
	system("clear");
}

sub write_log { # write to the log that all entries were viewed
	open LOG_FH, ">>logfile.txt";
	system("perl .get_date_time.pl >> logfile.txt");
	$action = "\tUser displayed all entries\n\n";
	print LOG_FH "$action";
	close LOG_FH;
	print "\nAction has been logged in logfile.txt\n\n";
}

sub check_blank_lines {
	# - check the file for blank lines
	# - blank lines make output very buggy
	# - I tried to remove them automatically,
	#   but found it very difficult
	open BLANK_FH, "information.txt";
	$blank_line_reader = "";
	$blank_line_count = 0;
	while ($blank_line_reader = <BLANK_FH>) {
		if ($blank_line_reader =~ /^\s*$/) {
			$blank_line_count += 1;
			#$blank_line_reader =~ s/^[^\S\n]*\n//gm;
		} else {
			next;
		}
	}

	if ($blank_line_count >= 1) {
		print "Blank line count: $blank_line_count\n";
		print "Blank lines found!\n";
		print "Output will be incorrectly formatted!\n";
		print "\tRecommendation: remove blank\n";
		print "\tlines from information.txt file\n";
		die "\n\tProgram will now exit\n\n";
	} else {
		&read_info_file;
	}
}

sub read_info_file {
	open INFO_FH, "information.txt";
	$info_line = "";
	$count = 1;
	while ($info_line = <INFO_FH>) {
		my @formatted_output = split /:/, $info_line;

		my $username   = $formatted_output[0];
		my $address    = $formatted_output[1];
		my $email      = $formatted_output[2];
		my $telephone  = $formatted_output[3];
		my $m_username = $formatted_output[4];
		my $start_date = $formatted_output[5];
		my $end_date   = $formatted_output[6];

		# open the /etc/passwd file to
		# find specific info on this user
		open PASSWD_FH, "/etc/passwd";
		$passwd_line = "";
		while ($passwd_line = <PASSWD_FH>) {
			chomp $passwd_line;
			@formatted_passwd = split (/:/, $passwd_line);
			$passwd_user = $formatted_passwd[0];
			if ($passwd_user eq $username) {
				$group_name = $formatted_passwd[2];
				$full_name  = $formatted_passwd[4];
				$home_dir   = $formatted_passwd[5];
				#print "test username: \"$passwd_user\"\n";
			}
		}

		print "Entry #$count\n";
		print "\tUsername:\t\t$username\n";
		print "\tFull name:\t\t$full_name\n";
		print "\tAddress:\t\t$address\n";
		print "\tHome directory:\t\t$home_dir\n";
		print "\tEmail address:\t\t$email\n";
		print "\tPrimary group name:\t$group_name\n";
		print "\tTelephone extension:\t$telephone\n";
		print "\tManager's username:\t$m_username\n";
		print "\tStart date:\t\t$start_date\n";
		print "\tEnd date:\t\t$end_date\n";
		print "=============",
		"===================",
		"===================",
		"===================\n";

		$count +=1;
	}
	close INFO_FH;
	close PASSWD_FH;
	#close GROUP_FH;

	&write_log;
	&less
}

sub less {
	# give the user to re-execute the script
	# while simulatenously piping to less.
	print "If the output is too much to fit on one screen,\n";
	print "enter \"less\" here to view the entries in less\n";
	print "format. This will allow for easier viewing\n\t-> ";
	$less_choice = <STDIN>;
	chomp $less_choice;

	if ($less_choice eq "less") {
		print "\n";
		print "   Note: to navigate in less format, use arrows\n";
		print "   (for line by line viewing), or \"f\" and \"b\"\n";
		print "   (for page by page viewing). Press \"q\" to quit\n";
		print "   less format. Pressing Ctrl+C may also be necessary\n";
		print "   in order to regain control of these keys.\n";
		print "\t Press ENTER to continue.\n\n";
		<STDIN>;
		system("perl 5_display_all.pl | less");
	} else {
		die "No decision made\n\n";
	}
}

&clear_screen;
&check_blank_lines;
