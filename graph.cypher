// =========================
// LIMPAR BANCO
// =========================
MATCH (n) DETACH DELETE n;


// =========================
// CRIAÇÃO COMPLETA (SEM NÓS SOLTOS)
// =========================
CREATE 

// USUARIOS
(levi:Usuario {nome:'Levi'}),
(josefias:Usuario {nome:'Josefias'}),
(fulano:Usuario {nome:'Fulano'}),

// ARTISTAS
(rappa:Artista {nome:'O Rappa'}),
(cbjr:Artista {nome:'Charlie Brown Jr.'}),
(racionais:Artista {nome:"Racionais MC's"}),

// GENEROS
(rock:Genero {nome:'Rock'}),
(reggae:Genero {nome:'Reggae'}),
(rap:Genero {nome:'Rap'}),

// MUSICAS
(m1:Musica {nome:'Minha Alma'}),
(m2:Musica {nome:'Me Deixa'}),
(m3:Musica {nome:'Zóio de Lula'}),
(m4:Musica {nome:'Céu Azul'}),
(m5:Musica {nome:'Diário de um Detento'}),
(m6:Musica {nome:'Jesus Chorou'}),

// =========================
// RELACIONAMENTOS
// =========================

// ARTISTA -> MUSICA
(rappa)-[:CRIOU]->(m1),
(rappa)-[:CRIOU]->(m2),

(cbjr)-[:CRIOU]->(m3),
(cbjr)-[:CRIOU]->(m4),

(racionais)-[:CRIOU]->(m5),
(racionais)-[:CRIOU]->(m6),

// MUSICA -> GENERO
(m1)-[:PERTENCE_A]->(rock),
(m1)-[:PERTENCE_A]->(reggae),
(m2)-[:PERTENCE_A]->(reggae),

(m3)-[:PERTENCE_A]->(rock),
(m4)-[:PERTENCE_A]->(rock),

(m5)-[:PERTENCE_A]->(rap),
(m6)-[:PERTENCE_A]->(rap),

// USUARIOS CURTIDAS
(levi)-[:CURTIU]->(m1),
(levi)-[:CURTIU]->(m3),

(josefias)-[:CURTIU]->(m2),
(josefias)-[:CURTIU]->(m5),

(fulano)-[:CURTIU]->(m3),
(fulano)-[:CURTIU]->(m6);


// =========================
// QUERY 1 - RECOMENDAÇÃO POR GENERO
// =========================
MATCH (u:Usuario {nome:'Levi'})-[:CURTIU]->(:Musica)-[:PERTENCE_A]->(g:Genero)
MATCH (rec:Musica)-[:PERTENCE_A]->(g)
WHERE NOT (u)-[:CURTIU]->(rec)
RETURN DISTINCT rec.nome AS recomendacao_por_genero
LIMIT 5;


// =========================
// QUERY 2 - RECOMENDAÇÃO COLABORATIVA
// =========================
MATCH (u:Usuario {nome:'Levi'})-[:CURTIU]->(m:Musica)
MATCH (outros:Usuario)-[:CURTIU]->(m)
MATCH (outros)-[:CURTIU]->(rec:Musica)
WHERE NOT (u)-[:CURTIU]->(rec)
AND u <> outros
RETURN DISTINCT rec.nome AS recomendacao_colaborativa
LIMIT 5;


// =========================
// QUERY 3 - VALIDAR RELACIONAMENTOS
// =========================
MATCH ()-[r]->()
RETURN count(r) AS total_relacionamentos;


// =========================
// VISUALIZAÇÃO DO GRAFO
// =========================
CALL db.schema.visualization();