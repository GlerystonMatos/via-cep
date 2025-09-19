-- 1. Cria o banco de dados
CREATE DATABASE "ViaCep";

-- Depois de criar, conecte ao banco "ViaCep" 

-- 2. Cria a tabela Endereco dentro do banco ViaCep
CREATE TABLE endereco (
    codigo SERIAL PRIMARY KEY,
    cep VARCHAR(10) NOT NULL,
    logradouro VARCHAR(255),
    complemento VARCHAR(255),
    unidade VARCHAR(255),
    bairro VARCHAR(255),
    localidade VARCHAR(255),
    uf CHAR(2),
    estado VARCHAR(100),
    regiao VARCHAR(255),
    ibge VARCHAR(20),
    gia VARCHAR(255),
    ddd VARCHAR(5),
    siafi VARCHAR(20)
);