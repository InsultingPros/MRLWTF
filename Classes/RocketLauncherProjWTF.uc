class RocketLauncherProjWTF extends LAWProj;

#exec AUDIO IMPORT NAME="WTFBOOM" FILE="WTFBOOM.wav"

var()	int		WaitCounter;
var()	float ShakeRadius;
var   sound BOOMSound;


simulated function Timer()
{
  WaitCounter++;

  if (WaitCounter == 20)
  {
    // BEEP BEEP BEEP WHAT THE FU-
    PlaySound(BOOMSound, , 10.0, , 5000.0);
  }
  else if (WaitCounter == 28)
  {
    if (SmokeTrail != none)
    {
      SmokeTrail.HandleOwnerDestroyed();
    }
    SetDrawScale(0.05);

    // BWWWAAAUUUUUUU-BWAHAHAHAHAHAHA
    spawn(class'RocketLauncherProjWTFExplosion', self,, self.Location, rotator(self.Location));
    if (ROLE == ROLE_AUTHORITY)
      KFGameType(Level.Game).DramaticEvent(1.0);
    Explode(Self.Location,Self.Location);
  }
  else if (WaitCounter > 28 && WaitCounter < 56)
  {
    if (Role == ROLE_Authority)
    {
      Damage *= 0.97;
    }
    Explode(self.Location, self.Location);
  }
  else if (WaitCounter >= 56)
  {
    Destroy();
  }
}


simulated function Explode(vector HitLocation, vector HitNormal)
{
  local Controller C;
  local PlayerController LocalPlayer;

  bHasExploded = True;

  BlowUp(HitLocation);

  LocalPlayer = Level.GetLocalPlayerController();
  if ((LocalPlayer != none) && (VSize(Location - LocalPlayer.ViewTarget.Location) < ShakeRadius))
    LocalPlayer.ShakeView(RotMag, RotRate, RotTime, OffsetMag, OffsetRate, OffsetTime);

  for (C = Level.ControllerList; C != none; C = C.NextController)
  {
    if ((PlayerController(C) != none) && (C != LocalPlayer) && (VSize(Location - PlayerController(C).ViewTarget.Location) < ShakeRadius))
    {
      C.ShakeView(RotMag, RotRate, RotTime, OffsetMag, OffsetRate, OffsetTime);
    }
  }
}


function TakeDamage(int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex){}


simulated singular function HitWall(vector HitNormal, actor Wall)
{
  Landed(HitNormal);
}


simulated function Landed(vector HitNormal)
{
  Velocity = vect(0, 0, 0);
  SetPhysics(PHYS_Falling);
  SetTimer(0.25, true);
  AmbientSound = none;
}


simulated function ProcessTouch(actor other, vector HitLocation)
{
  if (other == none || other == Instigator || other.Base == Instigator)
    return;

  if (bHasExploded)
    return;

  if (Instigator != none)
  {
    OrigLoc = Instigator.Location;
  }

  Landed(HitLocation);
}


defaultproperties
{
  ShakeRadius=2400.000000
  ImpactDamage=1
  Speed=1000.000000
  MaxSpeed=1000.000000
  Damage=3000.000000
  DamageRadius=1800.000000
  MyDamageType=class'DamTypeRocketLauncher'
  LifeSpan=30.000000
  BOOMSound=sound'WTFBOOM'
}