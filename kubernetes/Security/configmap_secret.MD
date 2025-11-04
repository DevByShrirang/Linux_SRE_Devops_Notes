apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  database_url: "postgresql://db:5432/mydb"
  log_level: "INFO"

A ConfigMap is a Kubernetes object that stores configuration data as key-value pairs, separate from application code.
This allows you to change configuration without rebuilding your container image.

Here:
database_url and log_level are keys.
Their values are simple strings.
Kubernetes stores this ConfigMap in etcd (the cluster’s key-value store).
Pods can then consume this ConfigMap data in two ways:
1) As environment variables.
2) As files mounted in a volume.


envFrom section used in pod/deployment.yaml
envFrom:
- configMapRef:
    name: app-config

Take all key value pair from configmap (app-config) and make them environment variable inside the container.

If application expect configuration from environment variable then we dont have to modify the image-just inject the configmap.

-------------
volumeMounts + volumes 

volumeMounts:
  - name: config
    mountPath: /etc/config
volumes:
 - name: config
   configMap:
     name: app:config


we can mount configmap as file inside the container filesystem at /etc/config
inside the container.
/etc/config/database_url
/etc/config/log_level

This Pod uses the app-config ConfigMap in two ways — as environment variables and as a mounted volume.
The envFrom directive imports all key-value pairs as environment variables, while the volumes section mounts the ConfigMap contents as files under /etc/config.
This dual approach allows flexibility depending on how the application consumes configuration — either through environment variables or file-based configuration.
The main benefit is that you can update configurations independently of the container image, and Kubernetes will automatically update the mounted files inside the running Pod.






