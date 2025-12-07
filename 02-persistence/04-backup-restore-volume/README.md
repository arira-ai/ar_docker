# Exercise 04 — Backup & Restore a Volume

## Concept
You must know how to backup and restore data stored in volumes. A common pattern uses a temporary container to tar up a volume's contents and store the archive on the host, and vice versa to restore.

## The Challenge
1. Create a volume `john_backup_demo` and write a sample file into it.
2. Backup the volume to a tar archive on the host: `john_backup.tar`.
3. Remove the volume contents and then restore from the backup tar to validate the method.

## Solution — exact commands

```bash
# 1) Create volume and write a file
docker volume create john_backup_demo
docker run --rm -v john_backup_demo:/data busybox sh -c "echo 'important data' > /data/important.txt"

# 2) Backup to host path (creates archive at the host cwd)
docker run --rm -v john_backup_demo:/data -v "$(pwd)":/backup busybox   sh -c "cd /data && tar czf /backup/john_backup.tar.gz ."

# Verify backup exists on host
ls -lh john_backup.tar.gz

# 3) Remove contents from the volume (overwrite)
docker run --rm -v john_backup_demo:/data busybox sh -c "rm -rf /data/* || true"

# 4) Confirm empty
docker run --rm -v john_backup_demo:/data busybox sh -c "ls -la /data || true"

# 5) Restore from backup archive
docker run --rm -v john_backup_demo:/data -v "$(pwd)":/backup busybox   sh -c "cd /data && tar xzf /backup/john_backup.tar.gz"

# 6) Confirm restore
docker run --rm -v john_backup_demo:/data busybox sh -c "cat /data/important.txt"
```

## Expected Output

```
# docker volume create john_backup_demo
john_backup_demo

# docker run ... echo 'important data'
# (no output; success)

# docker run ... tar czf /backup/john_backup.tar.gz .
# (no output; archive created)

# ls -lh john_backup.tar.gz
-rw-r--r-- 1 user user 1.0K Dec  4 12:34 john_backup.tar.gz

# docker run ... rm -rf /data/*
# (no output)

# docker run ... ls -la /data
total 0
drwxr-xr-x    2 root     root          4096 Dec  4 12:35 .
drwxr-xr-x    1 root     root          4096 Dec  4 12:35 ..

# after restore
# docker run ... cat /data/important.txt
important data
```

## K8s Connection
In Kubernetes, backup/restore of data on PVs is usually handled by tools (Velero, restic, custom jobs) or by mounting PVs into backup Pods and performing similar tar/copy operations. Important differences: permission model, storage backend, and cluster-level tools.
