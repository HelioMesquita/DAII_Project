CREATE DATABASE IF NOT EXISTS QuantumFinance;
USE QuantumFinance;

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Clients (
    cpf CHAR(11) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    mail VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    zip_code VARCHAR(8) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- Tabela de Produtos
CREATE TABLE IF NOT EXISTS Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    manufacturer VARCHAR(255) NOT NULL,
    color ENUM('black', 'white', 'gray') NOT NULL,
    size ENUM('p', 'm', 'g') NOT NULL
);

-- Tabela de Pedidos
CREATE TABLE IF NOT EXISTS Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_cpf CHAR(11),
    endereco VARCHAR(255),
    cep CHAR(8),
    valor_pago DECIMAL(10,2),
    FOREIGN KEY (cliente_cpf) REFERENCES Clients(cpf)
);

-- Tabela de Itens do Pedido
CREATE TABLE IF NOT EXISTS OrderItens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

INSERT INTO Products (name, model, manufacturer, color, size) VALUES
('Camiseta Básica', 'B100', 'QuantumWear', 'black', 'm'),
('Camiseta Esportiva', 'E200', 'QuantumWear', 'white', 'g'),
('Camiseta Polo', 'P300', 'QuantumWear', 'gray', 'p'),
('Camiseta Casual', 'C400', 'QuantumWear', 'black', 'g'),
('Camiseta Estampada', 'E500', 'QuantumWear', 'white', 'm'),
('Camiseta Manga Longa', 'M600', 'QuantumWear', 'gray', 'g'),
('Camiseta Regata', 'R700', 'QuantumWear', 'black', 'p'),
('Camiseta Oversized', 'O800', 'QuantumWear', 'white', 'm'),
('Camiseta Slim Fit', 'S900', 'QuantumWear', 'gray', 'g'),
('Camiseta Tech', 'T1000', 'QuantumWear', 'black', 'm');

INSERT INTO Clients (cpf, name, mail, address, zip_code, phone) VALUES
('12345678901', 'João Silva', 'joao@email.com', 'Rua A, 100', '01001000', '11999990001'),
('23456789012', 'Maria Souza', 'maria@email.com', 'Rua B, 200', '02002000', '11999990002'),
('34567890123', 'Carlos Lima', 'carlos@email.com', 'Rua C, 300', '03003000', '11999990003'),
('45678901234', 'Ana Rocha', 'ana@email.com', 'Rua D, 400', '04004000', '11999990004'),
('56789012345', 'Paulo Reis', 'paulo@email.com', 'Rua E, 500', '05005000', '11999990005'),
('67890123456', 'Juliana Alves', 'juliana@email.com', 'Rua F, 600', '06006000', '11999990006'),
('78901234567', 'Bruno Costa', 'bruno@email.com', 'Rua G, 700', '07007000', '11999990007'),
('89012345678', 'Fernanda Dias', 'fernanda@email.com', 'Rua H, 800', '08008000', '11999990008'),
('90123456789', 'Rafael Gomes', 'rafael@email.com', 'Rua I, 900', '09009000', '11999990009'),
('01234567890', 'Larissa Pinto', 'larissa@email.com', 'Rua J, 1000', '10010000', '11999990010');

-- Pedidos (Orders)
INSERT INTO Orders (cliente_cpf, endereco, cep, valor_pago) VALUES
('12345678901', 'Rua A, 100', '01001000', 79.90),
('23456789012', 'Rua B, 200', '02002000', 129.90),
('34567890123', 'Rua C, 300', '03003000', 59.90),
('45678901234', 'Rua D, 400', '04004000', 149.80),
('56789012345', 'Rua E, 500', '05005000', 89.90),
('67890123456', 'Rua F, 600', '06006000', 109.90),
('78901234567', 'Rua G, 700', '07007000', 59.90),
('89012345678', 'Rua H, 800', '08008000', 119.80),
('90123456789', 'Rua I, 900', '09009000', 199.70),
('01234567890', 'Rua J, 1000', '10010000', 89.90);

-- Itens (OrderItens)
INSERT INTO OrderItens (order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 1, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 3, 1),
(8, 7, 1),
(8, 8, 1),
(9, 2, 2),
(9, 10, 1),
(10, 9, 1);