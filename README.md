# MovieOn

MovieOn e um aplicativo Flutter para consultar filmes e series pela API TMDB, salvar favoritos localmente e escrever resenhas pessoais.

## Funcionalidades

- Consulta de filmes e series em destaque
- Busca por titulo
- Tela de detalhes com sinopse, generos e indicadores do titulo
- Favoritos persistidos localmente
- Resenhas pessoais persistidas localmente
- Biblioteca com favoritos e resenhas salvas

## Arquitetura e stack

- Arquitetura: MVVM em camadas
- Gerenciamento de estado: Riverpod
- Injeção de dependencias: GetIt
- HTTP: Dio
- Persistencia local: SharedPreferences
- Design patterns: Repository, Mapper e Observer via providers

## Telas

1. Inicio
2. Detalhes
3. Biblioteca

## Como executar

1. Instale o Flutter SDK compatível com o projeto.
2. Gere as dependencias:

```bash
flutter pub get
```

3. Execute o app informando a chave da TMDB:

```bash
flutter run --dart-define=TMDB_API_KEY=SUA_CHAVE_AQUI
```

Sem a chave, a tela inicial exibira uma mensagem de configuracao em vez de carregar o catalogo.

## Testes

Executar a suíte:

```bash
flutter test
```

O detalhamento tecnico do projeto esta em [docs/relatorio.md](docs/relatorio.md).

## Estrutura principal

- [lib/main.dart](lib/main.dart)
- [lib/app/movie_on_app.dart](lib/app/movie_on_app.dart)
- [lib/core/di/service_locator.dart](lib/core/di/service_locator.dart)
- [lib/features/home/presentation/screens/home_screen.dart](lib/features/home/presentation/screens/home_screen.dart)
- [lib/features/details/presentation/screens/details_screen.dart](lib/features/details/presentation/screens/details_screen.dart)
- [lib/features/library/presentation/screens/library_screen.dart](lib/features/library/presentation/screens/library_screen.dart)
