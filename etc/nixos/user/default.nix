{ config, pkgs, lib, ... }:

{
  users.motd =
''
Kernel \r on an \n. Today(\t) on tty \l

--------------------------------------------

Cogito, ergo sum.

Co-exist with Heaven and Earth, and united with everything.

--------------------------------------------
     _   __              ___
    | | / / ___   ___   / _/  ____  __ __
    | |/ / / _ \ / _ \ / _/  / __/ / // /
    |___/  \___//_//_//_/   /_/    \_, /
                                  /___/
--------------------------------------------

              Let's hacking!!

--------------------------------------------

'';
  imports = [
    ./vonfry
    ./local
  ];
}
