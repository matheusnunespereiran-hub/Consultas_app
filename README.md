# Minhas Consultas

Aplicativo simples para cadastrar e organizar consultas.

## Funcionalidades

- Criar conta, entrar e sair.
- Cadastrar, visualizar, editar e excluir consultas.
- Validar campos básicos.
- Salvar dados localmente no aparelho.

## Tecnologias

- Flutter
- Dart
- shared_preferences

## Como executar

1. Instale o Flutter.
2. Baixe ou clone este repositório.
3. Execute `flutter pub get`.
4. Execute `flutter run`.

## Como funciona

O `AuthService` cuida do cadastro e login local.
O `ConsultaService` salva e lê as consultas.
Os dados ficam no aparelho usando `shared_preferences`.

Esta versão é apenas didática: não use para guardar senhas ou dados reais
de pacientes. Os dados não são sincronizados entre aparelhos.
