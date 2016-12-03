# project-discovery
watched for changes on new or deleted projects and do some action.
In this case the action is to create an "-ops" project that sets up a "proxy" service.

# Setup
```
oc project ops
oc new-app --code=https://github.com/sterburg/project-discovery.git
```

Allow container to query projects:
```
oc adm policy add-cluster-role-to-user system:cluster-reader -z default
```

