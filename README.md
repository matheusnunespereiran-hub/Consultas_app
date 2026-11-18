# Organizador de Consultas

Aplicativo didático feito com Flutter e Dart para cadastrar e organizar consultas.

## Funcionalidades

- Cadastro local de usuário, login e logout.
- Cadastro de consultas.
- Listagem das consultas cadastradas.
- Edição e exclusão de consultas.
- Validação dos campos obrigatórios.

## Tecnologias

- Flutter
- Dart
- `shared_preferences` para salvar os dados localmente no dispositivo.

## Estrutura principal

```text
lib/
├── main.dart
├── models/
│   └── consulta.dart
├── services/
│   ├── auth_service.dart
│   └── consulta_service.dart
└── screens/
    ├── login_screen.dart
    ├── cadastro_screen.dart
    ├── home_screen.dart
    └── formulario_consulta_screen.dart
