// Created by Mistery, fixed and uploaded by NikC-
class MutMRWTF extends Mutator;


function ModifyPlayer(Pawn Player)
{
  super.ModifyPlayer(Player);
  Player.GiveWeapon(string(class'RocketLauncher'));
}


defaultproperties
{
  bAddToServerPackages=True
  GroupName="KF-MRWTF"
  FriendlyName="WTF Rocket Launcher Mut"
  Description="Adds the WTF Rocket Launcher removed from WTF mod"
}