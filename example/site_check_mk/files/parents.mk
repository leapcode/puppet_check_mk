parents = [
 # all seattle hosts (except those tagged router) have router.example.org 
 #  as a parent
 ( "router.example.org", ["seattle", "!router"], ALL_HOSTS ),

 # KVM host
 ( "foo.example.org", [ "vm1.example.org", "vm1.example.org" ] ),
]
