{
  imports = [
    ./velen2077
  ];
  # Common system-wide user options should be defined
  # here to ensure that there aren't duplication of
  # options across user modules.

  # Make sure users are immutable, i.e. the password
  # is not able to be changed outside of the declarative
  # configuration.
  users.mutableUsers = false;
}
