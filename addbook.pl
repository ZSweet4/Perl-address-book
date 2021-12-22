use Term::ANSIColor;

#Clear Screen
system("clear");

#prompt for color
print color('RED'),"Select a number from the list below\n",color("reset");
print "1 - Display Address Book\n";
print "2 - Add Adress \n";
print "3 - Remove Address \n";
print "4 - Reset Address Book\n";
print "\n";
my $choice = <STDIN>;
chomp $choice;

system("clear");

#set file path
$file = "addbook.csv";

if ($choice == 2 ){
  print "Name: ";
  my $name = <STDIN>;
  chomp $name;

  print "Phone number ((XXX) XXX - XXX): ";
  my $number = <STDIN>;
  chomp $number;

  print "Email: ";
  my $email = <STDIN>;
  chomp $email;

  unless ($color eq "Error"){
    #open file for append 
    open OUT, ">>$file" or die "Cannot open $out for append:$!";
    print OUT "$name, $number, $email\n";
    close OUT;
    system("clear");
    print color('RED'),"Address added - updated list below\n",color("reset");
    print color('RED'),"Name, Phone Number, Email\n",color("reset");
    #call declare subroutine
    &printfile;
    #subroutine to print file contents to Screen
    sub printfile {
      open IN, $file or die "Cannot open $out for read:$!";
      while(<IN>){
        print; 
      }
      close IN;
    }
  }else {
    #Error condition 
    print "ERROR: Invalid Entry\n";
  }
  #Choice 2 just opens up the file
}elsif ($choice == 3){
  system("clear");
  $file ="addbook.csv";
  $tempfile="addbook.csv.bk";

  open ADDBOOK, $file or die "Cannot open $file for read :$!";
  while (<ADDBOOK>){
    print "$. - $_";
  }
  print "\n";
  print "Record to remove: ";
  my $removeline = <STDIN>;
  chomp($removeline); 
  close ADDBOOK;

  system("clear");

  &writefile;

  sub writefile ($file, $removeline){
    open ADDBOOK, $file or die "Cannot open $file for read :$!";
    open(ADDBOOKTEMP,'>',$tempfile) or die $!;
    while(<ADDBOOK>){
      unless ($. == $removeline){
        print ADDBOOKTEMP $_;
      }
    }
  
    system("cat $tempfile > $file");
    close ADDBOOK;
    close ADDBOOKTEMP;

    if (!-z $file){
      open ADDBOOKIN, $file or die "Cannot open $file for read :$!";
      print color("RED"), "Address deleted - file updated below\n\n", color("reset");
      print color("RED"), "Name, Phone Number, Email\n", color("reset");
      while (<ADDBOOKIN>){
        print;
      }
    } else {
      print color("RED"), "No address on file\n", color("reset");
    }
  }
  #chose 3 makes a temporary file and then delete the selected chose from the main file
}elsif ($choice == 1){
    #open file for append 
    if (!-x$file){
      open OUT, ">>$file" or die "Cannot open $out for append:$!";
      #print OUT "$name, $number, $email\n";
      close OUT;
      system("clear");
      print color('RED'),"Address Book Below\n",color("reset");
      print color('RED'),"Name, Phone Number, Email\n",color("reset");

      &printfile;

      sub printfile {
      open IN, $file or die "Cannot open $out for read:$!";
      while(<IN>){
        print; 
      }
      close IN;
    }
  }else {
    #Error condition 
    print "ERROR: Invalid Entry\n";
    }
  }elsif ($choice == 4) {
  truncate $file, 0;
  print color('RED'),"Address Book Reset\n",color("reset");

}
#Zachary Sweet
#11/4/2021