#!/usr/bin/perl -w
#########################
# Filename: .get_date_time.pl
# Purpose:  This file utilises the Perl localtime
#           function to obtain the current date
#           and time in this format:
#           day-month-year hours:minutes:seconds
#
#           While the script itself simply
#           generates the date and time, any
#           subroutine that calls this script
#           redirects the output to the logfile.
# Author:   Haydon Murdoch / hgm3
# Date started: 11/11/2013
#########################
#
sub obtain_localtime {
	# obtain all localtime data
	@time_data = localtime(time);
}

sub alter_localtime_data {
	# get day and month offset
	# @date = @time_data[3,4];
	$day = $time_data[3];
	# get "real" month
	$month = 1 + $time_data[4];
	# get "real" year
	$year = 1900 + $time_data[5];
	# get hours, minutes and seconds data
	@time = @time_data[2,1,0];
}

#sub alter_time_format {
#	if (length($time_data[2]) < 2) {
#		$hours = join('', 0, $time_data[2]);
#		print "$hours\n";
#		#$formatted_time = join(':', $hours, $time_data[1,0]);
#	}
#
#	if (length($time_data[1]) < 2) {
#		$minutes = join('', 0, $time_data[1]);
#		print "$minutes\n";
#	}
#
#	if (length($time_data[0]) < 2) {
#		$seconds = join('', 0, $time_data[0]);
#		print "$seconds\n";
#	}
#}

sub joining {
	# join the day and month offset with "real" year
	$join_year = join('-', , $day, $month, $year);
	# format the time array with colons
	$formatted_time = join(':', @time);
	# make string with all formatted data
	$current_date_time = join(' ', $join_year, $formatted_time);
}

sub printing {
	# print the formatted string
	print "$current_date_time\n";
}

&obtain_localtime;      # obtain all localtime data
&alter_localtime_data;  # alter the data obtained from localtime
#&alter_time_format;    # add zeroes if they are necessary
&joining;               # join the arrays in various ways
&printing;              # print the formatted final output
