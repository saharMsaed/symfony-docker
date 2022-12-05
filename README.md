# Galien

## Lancer le projet 

###  Requis sur la machine de développement :
* Docker et docker-compose
* Git

### Démarrage quotidien

Pour démarrer avec un build des images 

```bash
make start-with-build
```

Démarrer 

```bash
make start
```

### Arrêt quotidien 

```bash
make stop
```

## Tests

### Les tests unitaires (TestCase ou KernelTestCase), fonctionnels (WebTestCase) 

```bash
make tests
```

### Les tests phpunit avec le coverage 

```bash
make tests-coverage
```

Un dossier coverage est généré sous docs. Lancer index.html pour voir le résultat des tests avec le coverage
