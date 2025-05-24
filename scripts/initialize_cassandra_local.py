from cassandra.cluster import Cluster
from collections import namedtuple
from uuid import uuid4
import random

cluster = Cluster(['localhost'], port=9042)
session = cluster.connect()

# Cria o keyspace
session.execute("""
    CREATE KEYSPACE IF NOT EXISTS quantum_finance
    WITH replication = {
        'class': 'SimpleStrategy',
        'replication_factor': 1
    };
""")

session.set_keyspace('quantum_finance')

# Criar tabela/objeto de clientes
session.execute("""
    CREATE TABLE IF NOT EXISTS clients (
        cpf TEXT PRIMARY KEY,
        name TEXT,
        mail TEXT,
        address TEXT,
        zip_code TEXT,
        phone TEXT
    );
""")

# Criar tabela/objeto de produtos
session.execute("""
    CREATE TABLE IF NOT EXISTS products (
        id UUID PRIMARY KEY,
        name TEXT,
        model TEXT,
        manufacturer TEXT,
        color TEXT,
        size TEXT,
        price DECIMAL
    );
""")

# Criar tabela/objeto itens do pedido
session.execute("""
    CREATE TYPE IF NOT EXISTS order_item (
        product_id UUID,
        quantity INT,
        product_name TEXT
    );
""")

# Criar tabela/objeto de pedidos
session.execute("""
    CREATE TABLE IF NOT EXISTS orders (
        id UUID PRIMARY KEY,
        cliente_cpf TEXT,
        endereco TEXT,
        cep TEXT,
        valor_pago DECIMAL,
        items LIST<FROZEN<order_item>>
    );
""")

clients = [
        ("12345678901", "João Silva", "joao@email.com", "Rua A, 100", "01001000", "11999990001"),
        ("23456789012", "Maria Souza", "maria@email.com", "Rua B, 200", "02002000", "11999990002"),
        ("34567890123", "Carlos Lima", "carlos@email.com", "Rua C, 300", "03003000", "11999990003"),
        ("45678901234", "Ana Rocha", "ana@email.com", "Rua D, 400", "04004000", "11999990004"),
        ("56789012345", "Paulo Reis", "paulo@email.com", "Rua E, 500", "05005000", "11999990005"),
        ("67890123456", "Juliana Alves", "juliana@email.com", "Rua F, 600", "06006000", "11999990006"),
        ("78901234567", "Bruno Costa", "bruno@email.com", "Rua G, 700", "07007000", "11999990007"),
        ("89012345678", "Fernanda Dias", "fernanda@email.com", "Rua H, 800", "08008000", "11999990008"),
        ("90123456789", "Rafael Gomes", "rafael@email.com", "Rua I, 900", "09009000", "11999990009"),
        ("01234567890", "Larissa Pinto", "larissa@email.com", "Rua J, 1000", "10010000", "11999990010")
    ]

# Inseri clientes se a tabela estiver vazia
if session.execute("SELECT COUNT(*) FROM clients").one()[0] == 0:
    insert_stmt = session.prepare("""
        INSERT INTO clients (cpf, name, mail, address, zip_code, phone)
        VALUES (?, ?, ?, ?, ?, ?)
    """)

    for client in clients:
        session.execute(insert_stmt, client)

products = [
    (uuid4(), 'Camiseta Básica', 'B100', 'QuantumWear', 'black', 'm', 79.90),
    (uuid4(), 'Camiseta Esportiva', 'E200', 'QuantumWear', 'white', 'g', 70.00),
    (uuid4(), 'Camiseta Polo', 'P300', 'QuantumWear', 'gray', 'p', 89.90),
    (uuid4(), 'Camiseta Casual', 'C400', 'QuantumWear', 'black', 'g', 79.90),
    (uuid4(), 'Camiseta Estampada', 'E500', 'QuantumWear', 'white', 'm', 69.90),
    (uuid4(), 'Camiseta Manga Longa', 'M600', 'QuantumWear', 'gray', 'g', 100),
    (uuid4(), 'Camiseta Regata', 'R700', 'QuantumWear', 'black', 'p', 50),
    (uuid4(), 'Camiseta Oversized', 'O800', 'QuantumWear', 'white', 'm', 120),
    (uuid4(), 'Camiseta Slim Fit', 'S900', 'QuantumWear', 'gray', 'g', 90),
    (uuid4(), 'Camiseta Tech', 'T1000', 'QuantumWear', 'black', 'm', 110),
]

# Inseri produtos se a tabela estiver vazia
if session.execute("SELECT COUNT(*) FROM products").one()[0] == 0:
    insert_stmt = session.prepare("""
        INSERT INTO products (id, name, model, manufacturer, color, size, price)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """)

    # Inserção com uuid automático
    for product in products:
        session.execute(insert_stmt, product)

if session.execute("SELECT COUNT(*) FROM orders").one()[0] == 0:
    
    # Registra order_item
    OrderItem = namedtuple("OrderItem", ["product_id", "quantity", "product_name"])

    cluster.register_user_type('quantum_finance', 'order_item', OrderItem)

    for _ in range(10):
        client = random.choice(clients)
        order_id = uuid4()
        valor_total = 0
        items = []

        for prod in random.sample(products, 2):
            qty = random.randint(1, 3)
            valor_total += qty * prod[6]
            # items.append((prod[0], qty, prod[1]))

            items.append(OrderItem(
                product_id=prod[0],
                quantity=qty,
                product_name=prod[1]
            ))

        session.execute("""
            INSERT INTO orders (id, cliente_cpf, endereco, cep, valor_pago, items)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (order_id, client[0], client[3], client[4], valor_total, items))
