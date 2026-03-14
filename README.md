# MiniSocial

MiniSocial é um aplicativo mobile desenvolvido em Flutter que simula o feed de uma
rede social.

O projeto foi desenvolvido como atividade técnica para avaliação de habilidades em
desenvolvimento mobile utilizando Flutter.

O aplicativo permite autenticação de usuários, criação e visualização de posts com
imagens, comentários, localização do post e integração com recursos nativos do
dispositivo.

# Tecnologias utilizadas

## Mobile (https://github.com/RichardsonTsavo/minisocial)

- Flutter
- MobX (gerenciamento de estado)
- Flutter Modular (arquitetura e navegação)
- Dio (consumo de API)
- Local Auth (biometria)
- Image picker (captura de imagens com a câmera)
- Geolocator (metadata dos posts)
- Shared preferences (persistencia local)
- Flutter form builder (formulários)
- photo_manager (acesso a galeria e thumbs)

## Backend (https://github.com/RichardsonTsavo/minisocial-api)

- Spring Boot
- API REST

## Serviços externos

- OpenStreetMap (geocoding reverso para obter endereço a partir de latitude e
    longitude)


# Funcionalidades

## Autenticação

- Login com email e senha
- Registro de novos usuários
- Persistência de sessão
- Autenticação biométrica para acesso ao aplicativo

## Feed de posts

- Listagem de posts ordenados do mais recente para o mais antigo
- Infinite scroll com paginação
- Visualização de detalhes do post
- Comentários

## Criação de posts

- Seleção de imagens da galeria
- Captura de foto diretamente da câmera
- Preview da imagem antes do envio
- Adição de legenda (caption)
- Armazenamento da localização do post

## Perfil

- Visualização dos posts do usuário
- Logout

# Arquitetura do projeto

O projeto utiliza uma arquitetura modular baseada em features.

```
lib/app
├── modules/
│ ├── login/
│ ├── register/
│ ├── home/
│ │     ├── feed/
│ │     ├── create_post/
│ │     └── profile/
│ └── post_detail/
│
├── shared/
│ ├── models/
│ ├── repositories/
│ ├── services/
│ ├── utils/
│ └── widgets/
│
├── app_module.dart
└── app_widget.dart
```

Essa organização permite separar responsabilidades e facilita a escalabilidade da
aplicação.

# Gerenciamento de estado

O gerenciamento de estado foi implementado utilizando MobX, separando a lógica de
negócio da interface de usuário através de Stores.

Cada módulo possui sua própria store responsável por controlar o estado da tela.

# Consumo de API

O consumo da API foi implementado utilizando Dio.

Foi criado um HttpService singleton responsável por:

- inicializar o cliente HTTP
- definir o baseUrl
- configurar headers
- injetar o token de autenticação automaticamente


Os repositórios utilizam esse serviço para realizar as requisições ao backend.

# Modelo de Post

Cada post possui um FileDataModel responsável por representar o arquivo associado
ao post.

Esse modelo armazena:

- bytes do arquivo antes do upload
- URL da mídia após o upload
- nome do arquivo

Além disso, possui um metadata contendo:

- latitude
- longitude
- mimetype
- data de criação
- tipo do arquivo (imagem ou vídeo)

A estrutura foi planejada para suportar futuramente uploads de vídeo.

# Infinite Scroll

A listagem de posts utiliza paginação e carregamento incremental.

Os posts são carregados em lotes de 10 itens.

Quando o usuário se aproxima do final da lista (600px), a próxima página é
automaticamente carregada e adicionada a tela.

Isso permite manter a experiência de navegação fluida.


# Recurso nativo

O aplicativo utiliza autenticação biométrica do dispositivo para validar o acesso do
usuário.

Ao iniciar o aplicativo, caso exista uma sessão ativa salva localmente, o sistema
solicita autenticação biométrica antes de liberar o acesso à aplicação.

# Como executar o projeto

## Requisitos
```
- Front-end
    - Flutter SDK
    - Dart
    - Android Studio ou VSCode
- Back-end
    - SpringBoot
    - Java 17
    - Maven
```
## Mobile

flutter pub get
flutter run

## Backend

mvn spring-boot:run

# Demonstração

O vídeo de demonstração do aplicativo pode ser acessado no link abaixo:


[Link do vídeo]

# Autor

Richardson Tsavo Freitas Nascimento


**Nota:** Devido a este projeto ter sido criado para um teste prático com tempo limitado de 5 dias, o backend foi desenvolvido **mesmo sem conhecimento prévio em Spring Boot**, com base em estudo intensivo, experiência prévia em backend e apoio de ferramentas como ChatGPT.  
Portanto, pode não refletir todas as melhores práticas do mercado em backend, mas é totalmente funcional **para o fim que foi criado (fazer um banco de dados para o projeto minisocial)**