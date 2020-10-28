{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ammonite
    bloop
    coursier
    metals
    sbt
    scala
    scalafix
    scalafmt
  ];
}
