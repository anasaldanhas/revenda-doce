# 🍬 Sistema de Revenda de Doces — Ana Clara  

Bem-vindo(a) ao meu projeto de banco de dados para uma **revenda de doces**! 🎀  
Aqui você encontra toda a estrutura necessária para gerenciar clientes, pedidos, doces, fornecedores e pagamentos.  

## 📌 Sobre o Projeto  
O objetivo é simular um pequeno sistema de **loja de doces**, onde:  
- Clientes podem fazer pedidos 💌  
- Cada pedido contém vários docinhos 🍩  
- Os pedidos são pagos e controlados com status de entrega 💳  
- Há fornecedores responsáveis por abastecer os doces 🚚  

## 🗂️ Estrutura do Banco

📖 **Nome do banco:** `db_revenda_anaclara_doces`  

Tabelas criadas:  
1. **cliente** 👩‍💻 – cadastro de clientes  
2. **doce** 🍫 – docinhos disponíveis para venda  
3. **fornecedor** 🏭 – fornecedores da loja  
4. **pedido** 📦 – pedidos realizados pelos clientes  
5. **pedido_doce** 🔗 – ligação entre pedido e doce  
6. **pagamento** 💳 – registro dos pagamentos  

Views criadas:  
- `vw_pedidos_clientes` — mostra pedidos com dados do cliente 🧾  
- `vw_itens_pedido` — mostra os doces de cada pedido 🍪  



<img width="623" height="649" alt="doces" src="https://github.com/user-attachments/assets/1627b208-b36f-4ec6-aad2-d6081977c54a" />
