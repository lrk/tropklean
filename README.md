# Tropklean

Penser à désactiver l'ASLR sur le docker host avant de lancer le container ;)

```
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
```


## build

```
docker compose build
```

## Run 

```
docker compose up -d tropklean
```

## Klean

```
docker compose down
```