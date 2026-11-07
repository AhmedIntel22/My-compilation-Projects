# Rapport de Mini-Projet : Interpréteur Étendu

**Auteur :** Manus AI
**Date :** 03 Mai 2026

## 1. Introduction
Ce projet consiste à étendre un interpréteur d'expressions arithmétiques et logiques développé avec **Flex** et **Bison**. L'objectif était d'ajouter des fonctionnalités avancées tout en conservant la structure de base fournie dans le template.

## 2. Fonctionnalités Implémentées

| Fonctionnalité | Description |
| :--- | :--- |
| **Opérateurs de comparaison** | Ajout de `==`, `!=`, `<`, `>`, `<=`, `>=`. |
| **Opérateurs logiques** | Ajout de `&&` (ET), `||` (OU), `!` (NON). |
| **Types de données** | Support des nombres réels (`double`) au lieu de simples entiers. |
| **Gestion des erreurs** | Affichage du numéro de ligne précis lors d'une erreur de syntaxe ou sémantique. |
| **Commentaires** | Support des commentaires sur une ligne commençant par `//`. |

## 3. Modifications Apportées

### 3.1. Analyseur Lexical (`lex.l`)
- Ajout de règles pour reconnaître les nouveaux opérateurs (`==`, `&&`, etc.).
- Modification de la règle `NOMBRE` pour accepter les points décimaux (ex: `3.14`).
- Activation de `%option yylineno` pour le suivi des lignes.

### 3.2. Analyseur Syntaxique (`interpreteur.y`)
- Changement du type de valeur dans la table des symboles de `int` à `double`.
- Définition des priorités des nouveaux opérateurs (ex: `OU` < `ET` < `Comparaison`).
- Ajout des règles de grammaire pour les expressions logiques et les comparaisons.
- Amélioration de la fonction `yyerror` pour inclure `yylineno`.

## 4. Tests et Validation

### 4.1. Test d'affectation et calcul (Réels)
**Entrée :**
```c
a = 10;
b = 5.5;
c = a + b * 2;
print(c);
```
**Sortie :** `21` (Succès)

### 4.2. Test de structure conditionnelle et logique
**Entrée :**
```c
x = 5;
y = 10;
si x < y && y == 10 alors
    print(100);
sinon
    print(200);
fin
```
**Sortie :** `100` (Succès)

### 4.3. Test de division par zéro
**Entrée :**
```c
z = 10 / 0;
```
**Sortie :** `Erreur ligne X : Division par zero` (Succès)

## 5. Conclusion
L'interpréteur est désormais capable de gérer des calculs complexes avec des nombres réels, des conditions logiques imbriquées et fournit une meilleure aide au débogage grâce au suivi des lignes.
