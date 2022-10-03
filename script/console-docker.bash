#!/bin/bash
# TODO: Use static dockercontainer name
# TODO: Don't hardcode uid
docker exec -it -u 1000:1000 musing_fermi /bin/bash
