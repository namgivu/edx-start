# intro
My effort to self-hosted deploy edx app to the cloud; and I'll note here
ref. https://open.edx.org/get-started/get-started-self-managed/


# 0th blow
from home guide, we choose [install from source](https://openedx.atlassian.net/wiki/spaces/OpenOPS/pages/60227779/Open+edX+Installation+Options)

    > If you want a production-like installation for testing, use Native.
    we choose Native method which has [Native deploy with Ubuntu 16.04](https://openedx.atlassian.net/wiki/spaces/OpenOPS/pages/146440579/Native+Open+edX+Ubuntu+16.04+64+bit+Installation)

        > This will run MySQL, Memcache, Mongo, Nginx, and all of the Open edX services (LMS, Studio, Forums, ORA, etc) 
        [installation details](doc/install-edx.md)

# server requirements
Ubuntu `16.04 amd64` (oraclejdk required). It may seem like other versions of Ubuntu will be fine, but they are not.  Only 16.04 is known to work.
Minimum `8GB of memory`
At least one `2.00GHz CPU` or EC2 compute unit
Minimum `25GB of free disk`, 50GB recommended for production servers

For hosting in Amazon we recommend an t2.large with at least a 50Gb EBS volume, see https://aws.amazon.com/ec2/pricing. 


# misc note
get help by [asking here](https://open.edx.org/getting-help)

edX is a massive open online course, aka MOOC, provider

what is LMS? Learning Management System

TODO what is ORA?
