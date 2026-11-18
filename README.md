# Organizador de Consultas

Aplicativo didático feito com Flutter e Dart para cadastrar e organizar consultas.

## Funcionalidades

- Cadastro local de usuário, login e logout.
- Cadastro, listagem, edição e exclusão de consultas (CRUD).
- Validação dos campos obrigatórios.
- Cada conta local mantém sua própria lista de consultas neste dispositivo.

## Tecnologias

- Flutter e Dart.
- `shared_preferences` para armazenamento local simples.

## Estrutura do projeto

```text
lib/
├── main.dart
├── models/consulta.dart
├── services/
│   ├── auth_service.dart
│   └── consulta_service.dart
└── screens/
    ├── login_screen.dart
    ├── cadastro_screen.dart
    ├── home_screen.dart
    └── formulario_consulta_screen.dart
```

As pastas de plataforma e configuração do Flutter também estão neste repositório. O arquivo `consultas_app_flutter_completo.zip` contém uma cópia compactada do projeto. `consultas_app_web.zip` contém a versão Web compilada.

## Como executar

É necessário ter o Flutter instalado em um computador ou ambiente compatível.

1. Baixe ou clone este repositório.
2. Na pasta do projeto, execute `flutter pub get`.
3. Execute `flutter run` para iniciar em um dispositivo conectado.

Para executar no navegador, use `flutter run -d chrome`. Para compilar a versão Web, use `flutter build web --release`.

## Verificação

O teste unitário passou e a compilação Flutter Web foi concluída com sucesso neste ambiente. A análise estática também foi executada; no canal Flutter master usado aqui, ela apresentou avisos de depreciação relacionados ao pacote Material, sem erros de compilação.

## Limitações

Este é um protótipo didático. O cadastro e o login são locais; as senhas não são protegidas como em um sistema real. As consultas ficam salvas no dispositivo e não são sincronizadas pela internet. Não use este aplicativo para armazenar senhas ou informações reais e sensíveis de pacientes.
