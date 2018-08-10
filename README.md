# Crashplan Backup

## Connect via SSH tunnel

The CrashPlan configuration service is per default only available for localhost. With this configuration a ssh tunnel is needed to be able to connect to the server.

Procedure:

1. configure pubkey authentication
2. Open SSH tunnel from localhost:4200 to <server>:4243
3. ssh -L 4200:localhost:4243 <user@server>
4. read server authentication token from '.ui_info' on the server
5. set port=4200 and insert authentication token from the server in '.ui_info' on the client (& store a copy of '.ui_info' for each server)
6. start CrashPlan app & configure server

See: 

* http://support.code42.com/CrashPlan/4/Configuring/Using_CrashPlan_On_A_Headless_Computer
* http://support.code42.com/CrashPlan/4/Configuring/Using_CrashPlan_On_A_Headless_Computer#Locations_Of_.ui_info

### Example (OS X)

```
mv /Library/Application\ Support/CrashPlan/.ui_info /Library/Application\ Support/CrashPlan/.ui_info.bak
cp /Library/Application\ Support/CrashPlan/.ui_info.nas /Library/Application\ Support/CrashPlan/.ui_info
ssh -L 4200:localhost:4243 nas
open /Applications/CrashPlan.app
```