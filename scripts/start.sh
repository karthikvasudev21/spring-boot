 #!/bin/sh
export BASIC_AUTH_PASSWORD=$(cat /mnt/secrets-store/test)
java -jar /app.jar