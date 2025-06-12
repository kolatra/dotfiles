let 
    tyler = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEdQDJEnAKSK5MECKcpzcNFgPSs0BnHwCi53U88YTFN tyler";
in
{
    "restic/env.age".publicKeys = [ tyler ];
    "restic/repo.age".publicKeys = [ tyler ];
    "restic/password.age".publicKeys = [ tyler ];
}
