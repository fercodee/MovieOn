# Relatorio do Projeto MovieOn

## Visao geral

MovieOn foi desenvolvido como um aplicativo Flutter hibrido para consulta de filmes e series usando a API TMDB. O aplicativo permite descobrir titulos, consultar detalhes, salvar favoritos e escrever resenhas locais.

## Requisitos atendidos

### 1. Clean Code

O projeto foi organizado por responsabilidade e por feature, evitando concentrar regras de negocio na interface.

Exemplos:

- ViewModels separados por tela em [lib/features/home/presentation/viewmodels/home_view_model.dart](lib/features/home/presentation/viewmodels/home_view_model.dart), [lib/features/details/presentation/viewmodels/details_view_model.dart](lib/features/details/presentation/viewmodels/details_view_model.dart) e [lib/features/library/presentation/viewmodels/library_view_model.dart](lib/features/library/presentation/viewmodels/library_view_model.dart)
- Casos de uso pequenos e focados em [lib/features/catalog/domain/usecases/get_trending_media_use_case.dart](lib/features/catalog/domain/usecases/get_trending_media_use_case.dart), [lib/features/catalog/domain/usecases/search_media_use_case.dart](lib/features/catalog/domain/usecases/search_media_use_case.dart) e [lib/features/library/domain/usecases/toggle_favorite_use_case.dart](lib/features/library/domain/usecases/toggle_favorite_use_case.dart)
- Entidades de dominio separadas da camada de dados em [lib/features/shared/domain/media_item.dart](lib/features/shared/domain/media_item.dart), [lib/features/details/domain/entities/media_details.dart](lib/features/details/domain/entities/media_details.dart) e [lib/features/library/domain/entities/review.dart](lib/features/library/domain/entities/review.dart)

### 2. Arquitetura de Software

Foi adotada a arquitetura MVVM em camadas.

Estrutura:

- Presentation: telas, widgets, estados e viewmodels
- Domain: entidades, contratos e casos de uso
- Data: data sources, models e repositories

Arquivos representativos:

- [lib/features/catalog/domain/repositories/catalog_repository.dart](lib/features/catalog/domain/repositories/catalog_repository.dart)
- [lib/features/catalog/data/repositories/catalog_repository_impl.dart](lib/features/catalog/data/repositories/catalog_repository_impl.dart)
- [lib/features/library/domain/repositories/library_repository.dart](lib/features/library/domain/repositories/library_repository.dart)
- [lib/features/library/data/repositories/library_repository_impl.dart](lib/features/library/data/repositories/library_repository_impl.dart)

### 3. Injeção de Dependencia

Foi utilizado GetIt como container de DI.

Implementacao principal em [lib/core/di/service_locator.dart](lib/core/di/service_locator.dart).

O arquivo registra:

- Dio
- SharedPreferences
- Data sources
- Repositories
- Casos de uso

Os providers para a camada de apresentacao ficam em [lib/core/di/app_providers.dart](lib/core/di/app_providers.dart).

### 4. Testes Unitarios

Foram implementados pelo menos 5 testes unitarios cobrindo regras reais do projeto.

Arquivos:

- [test/catalog/domain/usecases/get_trending_media_use_case_test.dart](test/catalog/domain/usecases/get_trending_media_use_case_test.dart)
- [test/catalog/domain/usecases/search_media_use_case_test.dart](test/catalog/domain/usecases/search_media_use_case_test.dart)
- [test/details/domain/usecases/get_media_details_use_case_test.dart](test/details/domain/usecases/get_media_details_use_case_test.dart)
- [test/library/domain/usecases/toggle_favorite_use_case_test.dart](test/library/domain/usecases/toggle_favorite_use_case_test.dart)
- [test/library/domain/usecases/save_review_use_case_test.dart](test/library/domain/usecases/save_review_use_case_test.dart)
- [test/shared/data/models/media_item_model_test.dart](test/shared/data/models/media_item_model_test.dart)

### 5. Design Patterns

Os seguintes padrões foram aplicados:

- Repository Pattern: abstrai o acesso aos dados remotos e locais
- Mapper Pattern: converte respostas da TMDB e dados locais em entidades de dominio
- Observer: Riverpod reage as mudancas de estado da UI

Arquivos representativos:

- [lib/features/shared/data/models/media_item_model.dart](lib/features/shared/data/models/media_item_model.dart)
- [lib/features/details/data/models/media_details_model.dart](lib/features/details/data/models/media_details_model.dart)
- [lib/features/library/data/models/review_model.dart](lib/features/library/data/models/review_model.dart)

### 6. Interface com pelo menos 3 telas funcionais

O app possui tres telas principais:

1. Inicio
Responsavel por listar filmes ou series em destaque e realizar busca.
Arquivo: [lib/features/home/presentation/screens/home_screen.dart](lib/features/home/presentation/screens/home_screen.dart)

2. Detalhes
Exibe informacoes completas do titulo, permite favoritar e salvar resenha.
Arquivo: [lib/features/details/presentation/screens/details_screen.dart](lib/features/details/presentation/screens/details_screen.dart)

3. Biblioteca
Mostra favoritos e resenhas persistidas localmente.
Arquivo: [lib/features/library/presentation/screens/library_screen.dart](lib/features/library/presentation/screens/library_screen.dart)

## Gerenciamento de estado da UI

Foi utilizado Riverpod com AsyncNotifier e estado imutavel por tela.

Exemplos:

- [lib/features/home/presentation/viewmodels/home_view_model.dart](lib/features/home/presentation/viewmodels/home_view_model.dart)
- [lib/features/details/presentation/viewmodels/details_view_model.dart](lib/features/details/presentation/viewmodels/details_view_model.dart)
- [lib/features/library/presentation/viewmodels/library_view_model.dart](lib/features/library/presentation/viewmodels/library_view_model.dart)

## Persistencia local

Favoritos e resenhas sao persistidos localmente usando SharedPreferences por meio de [lib/features/library/data/datasources/library_local_data_source.dart](lib/features/library/data/datasources/library_local_data_source.dart).

## Consumo da API TMDB

A integracao remota esta concentrada em [lib/features/catalog/data/datasources/tmdb_remote_data_source.dart](lib/features/catalog/data/datasources/tmdb_remote_data_source.dart).

A chave da API deve ser informada em tempo de execucao com:

```bash
flutter run --dart-define=TMDB_API_KEY=SUA_CHAVE_AQUI
```

## Observacao final

O projeto foi estruturado para permitir evolucao incremental de funcionalidades sem acoplamento direto entre interface, regras de negocio e fontes de dados.