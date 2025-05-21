-- Criar keyspace
CREATE KEYSPACE IF NOT EXISTS quantum_finance
WITH replication = { 'class': 'SimpleStrategy', 'replication_factor': 1 };

USE quantum_finance;

-- Criar tipo composto para itens do pedido
CREATE TYPE IF NOT EXISTS order_item (
    product_id UUID,
    quantity INT,
    product_name TEXT
);

-- Criar tabela de clientes
CREATE TABLE IF NOT EXISTS clients (
    cpf TEXT PRIMARY KEY,
    name TEXT,
    mail TEXT,
    address TEXT,
    zip_code TEXT,
    phone TEXT
);

-- Criar tabela de produtos
CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY,
    name TEXT,
    model TEXT,
    manufacturer TEXT,
    color TEXT,
    size TEXT
);

-- Criar tabela de pedidos (orders)
CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY,
    cliente_cpf TEXT,
    endereco TEXT,
    cep TEXT,
    valor_pago DECIMAL,
    items LIST<FROZEN<order_item>>
);

-- Inserir clientes
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('12345678901', 'João Silva', 'joao@email.com', 'Rua A, 100', '01001000', '11999990001');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('23456789012', 'Maria Souza', 'maria@email.com', 'Rua B, 200', '02002000', '11999990002');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('34567890123', 'Carlos Lima', 'carlos@email.com', 'Rua C, 300', '03003000', '11999990003');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('45678901234', 'Ana Rocha', 'ana@email.com', 'Rua D, 400', '04004000', '11999990004');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('56789012345', 'Paulo Reis', 'paulo@email.com', 'Rua E, 500', '05005000', '11999990005');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('67890123456', 'Juliana Alves', 'juliana@email.com', 'Rua F, 600', '06006000', '11999990006');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('78901234567', 'Bruno Costa', 'bruno@email.com', 'Rua G, 700', '07007000', '11999990007');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('89012345678', 'Fernanda Dias', 'fernanda@email.com', 'Rua H, 800', '08008000', '11999990008');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('90123456789', 'Rafael Gomes', 'rafael@email.com', 'Rua I, 900', '09009000', '11999990009');
INSERT INTO clients (cpf, name, mail, address, zip_code, phone) VALUES
('01234567890', 'Larissa Pinto', 'larissa@email.com', 'Rua J, 1000', '10010000', '11999990010');

-- Inserir produtos com UUIDs gerados manualmente (poderia ser automático pela aplicação)

-- NOTA: Gere os UUIDs reais usando sua linguagem ou ferramental, exemplo com `uuid()` abaixo:

INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Básica', 'B100', 'QuantumWear', 'black', 'm');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Esportiva', 'E200', 'QuantumWear', 'white', 'g');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Polo', 'P300', 'QuantumWear', 'gray', 'p');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Casual', 'C400', 'QuantumWear', 'black', 'g');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Estampada', 'E500', 'QuantumWear', 'white', 'm');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Manga Longa', 'M600', 'QuantumWear', 'gray', 'g');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Regata', 'R700', 'QuantumWear', 'black', 'p');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Oversized', 'O800', 'QuantumWear', 'white', 'm');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Slim Fit', 'S900', 'QuantumWear', 'gray', 'g');
INSERT INTO products (id, name, model, manufacturer, color, size) VALUES (uuid(), 'Camiseta Tech', 'T1000', 'QuantumWear', 'black', 'm');

-- Inserir pedidos (1 pedido simples como exemplo com items fixos)
INSERT INTO orders (id, cliente_cpf, endereco, cep, valor_pago, items)
VALUES (
  uuid(),
  '12345678901',
  'Rua A, 100',
  '01001000',
  159.80,
  [
    {product_id: uuid(), quantity: 1, product_name: 'Camiseta Básica'},
    {product_id: uuid(), quantity: 2, product_name: 'Camiseta Tech'}
  ]
);