class RocketLauncherFire extends LAWFire;


function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
  local Projectile P;

  if (FRand() <= 0.05)
    P = Weapon.Spawn(class'RocketLauncherProjWTF',,, Start, Dir);
  else
    P = Weapon.Spawn(ProjectileClass,,, Start, Dir);

  if (P == none)
    return none;

  P.Damage *= DamageAtten;
  return P;
}


defaultproperties
{
  AmmoClass=class'RocketLauncherAmmo'
  ProjectileClass=class'RocketLauncherProjWTF'
}