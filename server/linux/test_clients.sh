#!/bin/bash

# srv stats:
docker exec -it chrony_srv chronyc clients
docker exec -it chrony_srv chronyc tracking

# Give it 10 seconds, then check your server's live tracking status:
docker exec -it chrony_srv chronyc sources -v
