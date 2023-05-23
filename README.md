# pokemon

Projeto com recursos avançados de listagem de pokémons, incluindo paginação e lista infinita. Além disso, é possível ordenar a lista tanto pelo índice do pokémon quanto em ordem alfabética. Adicionalmente, implementei uma funcionalidade de pesquisa que permite encontrar informações específicas sobre um determinado pokémon.


## Getting Started

- Primeiro passo: tenha o flutter instalado na sua maquina. Caso nao tenha [clique aqui](https://docs.flutter.dev/get-started/install)
- Segundo passo: tenha uma IDE configurada para o flutter, recomendo duas opções, [Android Studio](https://developer.android.com/studio?gclid=CjwKCAjw9pGjBhB-EiwAa5jl3Botj8xaOVWTeQ_ULegGS1pa6WEReQg5Mg99oBgYs68-djOoB42ZKhoCE2MQAvD_BwE&gclsrc=aw.ds) ou [Visual Studio Code](https://code.visualstudio.com/download)
- Terceiro passo: faça o clone deste projeto utilizando o [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Quarto passo abra o projeto na sua IDE e rode o projeto.

## Pacotes utilizados 

- dio: ^5.1.2
- flutter_dotenv: ^5.0.2
- bloc: ^8.1.1
- flutter_bloc: ^8.1.2
-  provider: ^6.0.5
-  equatable: ^2.0.5
-  percent_indicator: ^4.2.3

## Estrutura de diretórios

├── lib
|   ├── src
|   |   ├── core
|   |   ├── modules
|   |   ├── pokemon_app.dart
|   ├── main.dart
├── test
└── README.md 

- core: apresenta todos os componentes, classes auxiliares, tema do projeto.
- modules: apresenta todos os modulos do projeto e suas funcionalidades
- pokemon_app_dart: arquivo onde define qual é o tema de acordo com o tema definido dentro de core e rotas das paginas.
- main.dart: arquivo onde inicializa a aplicação
- test: tem todos os testes unitarios do projeto garantindo que o projeto está funcional
- README.md: documentação do projeto