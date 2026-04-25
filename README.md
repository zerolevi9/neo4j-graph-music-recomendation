# 🎵 Sistema de Recomendação de Músicas com Neo4j

Este projeto demonstra a construção de um **grafo de músicas** utilizando **Neo4j** e a linguagem **Cypher**, com foco em recomendações baseadas em:

- 🎧 Preferências por gênero  
- 👥 Filtragem colaborativa entre usuários  

---

## 📌 Estrutura do Grafo

O banco de dados é composto pelos seguintes tipos de nós:

### 👤 Usuários
- Levi  
- Josefias  
- Fulano  

### 🎤 Artistas
- O Rappa  
- Charlie Brown Jr.  
- Racionais MC's  

### 🎼 Gêneros
- Rock  
- Reggae  
- Rap  

### 🎶 Músicas
- Minha Alma  
- Me Deixa  
- Zóio de Lula  
- Céu Azul  
- Diário de um Detento  
- Jesus Chorou  

---

## 🔗 Relacionamentos

O grafo conecta os dados através dos seguintes relacionamentos:

- `(:Artista)-[:CRIOU]->(:Musica)`  
- `(:Musica)-[:PERTENCE_A]->(:Genero)`  
- `(:Usuario)-[:CURTIU]->(:Musica)`  

---

## 🔍 Queries

### 🎯 Recomendação por Gênero

```cypher
MATCH (u:Usuario {nome:'Levi'})-[:CURTIU]->(:Musica)-[:PERTENCE_A]->(g:Genero)
MATCH (rec:Musica)-[:PERTENCE_A]->(g)
WHERE NOT (u)-[:CURTIU]->(rec)
RETURN DISTINCT rec.nome AS recomendacao_por_genero
LIMIT 5;
```

**Explicação:**
- Usa gêneros das músicas curtidas
- Busca músicas similares
- Remove já curtidas

---

### 🤝 Recomendação Colaborativa

```cypher
MATCH (u:Usuario {nome:'Levi'})-[:CURTIU]->(m:Musica)
MATCH (outros:Usuario)-[:CURTIU]->(m)
MATCH (outros)-[:CURTIU]->(rec:Musica)
WHERE NOT (u)-[:CURTIU]->(rec)
AND u <> outros
RETURN DISTINCT rec.nome AS recomendacao_colaborativa
LIMIT 5;
```

**Explicação:**
- Encontra usuários similares
- Sugere músicas deles
- Filtra desconhecidas

---

### 📊 Validação

```cypher
MATCH ()-[r]->()
RETURN count(r) AS total_relacionamentos;
```

---

### 👁️ Visualização

```cypher
CALL db.schema.visualization();
```

---

## 🚀 Objetivo

- Modelagem em grafos  
- Sistema de recomendação  
- Filtragem colaborativa  
- Uso de Cypher  

---

## 🧠 Melhorias Futuras

- Peso nas relações  
- Recomendação híbrida  
- Mais dados  
- API (Node/Python)  
- Frontend  

---

## 🛠️ Tecnologias

- Neo4j  
- Cypher  

---

## 📎 Como Usar

1. Abrir Neo4j Browser  
2. Executar script  
3. Rodar queries  
4. Visualizar grafo  

---

Feito para fins educacionais 🚀
