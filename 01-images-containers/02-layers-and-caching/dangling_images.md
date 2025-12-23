# Docker Dangling Images – Practice Guide

## What are Dangling Images?

**Dangling images** are Docker images that:

* Have **no tag**
* Are shown as `<none>:<none>`
* Are **not referenced** by any container
* Usually created when:

  * You rebuild an image
  * A build fails midway
  * Image layers are replaced by a new build

They **consume disk space** but are **not useful**.



## How Dangling Images are Created (Example)

```bash
docker build -t myapp:v1 .
docker build -t myapp:v2 .
```

Now the old image layers become **dangling**.


## List Dangling Images

### Command

```bash
docker images -f dangling=true
```

### Sample Output

```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
<none>       <none>    a1b2c3d4e5f6   2 days ago     125MB
```

## List All Images (To Compare)

```bash
docker images
```

Look for:

```
<none>   <none>
```

## Remove Dangling Images (Safe Cleanup)

```bash
docker image prune
```

### Interactive prompt:

```
WARNING! This will remove all dangling images.
Are you sure you want to continue? [y/N]
```

Type:

```
y
```

## Remove Dangling Images Without Prompt

```bash
docker image prune -f
```


## Remove Specific Dangling Image

```bash
docker rmi <IMAGE_ID>
```

Example:

```bash
docker rmi a1b2c3d4e5f6
```

## Remove ALL Unused Images (Be Careful)

```bash
docker image prune -a
```

This removes:

* Dangling images
* Unused tagged images

**Do NOT run in production casually**


## Difference: Dangling vs Unused Images

| Type           | Description           | Safe to Delete |
| -------------- | --------------------- | -------------- |
| Dangling Image | `<none>:<none>`       | ✅ Yes          |
| Unused Image   | Tagged but not used   | ⚠️ Depends     |
| Used Image     | Attached to container | ❌ No           |


## Disk Space Check (Before & After)

```bash
docker system df
```

Shows:

* Images
* Containers
* Volumes
* Build cache


## Best Practice

* Clean dangling images **regularly**
* Use:

```bash
docker image prune
```

* In CI pipelines, cleanup after builds


## Practice Tasks (For Freshers)

1. Build an image twice with different tags
2. Identify dangling images
3. Remove dangling images
4. Verify disk usage before & after


## One-Line Cleanup Command (Good Demo)

```bash
docker images -f dangling=true && docker image prune -f
```
