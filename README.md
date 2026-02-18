# PhotoAlbums

Projeto de teste desenvolvido em Flutter com integração de API REST e funcionalidades nativas de Deep Linking (para aplicativos de e-mail e mapas).

O projeto consiste em um aplicativo móvel que simula um álbum de fotos compartilhado na nuvem, permitindo a visualização de detalhes, identificação de autores e interação com o conteúdo.

![Prototipo do projeto](./assets/teste_tecnico.jpeg)

## Considerações sobre a API

Para analisar e executar este projeto corretamente, é necessário compreender três limitações técnicas relacionadas à API pública utilizada (JSONPlaceholder):

1. **Relacionamento entre Classes:**
   Nesta API, as entidades Foto e Post se relacionam apenas através do Usuário, não existindo um vínculo direto entre si. Para fins didáticos e de demonstração, o projeto adota a premissa de igualdade de IDs: uma foto é tratada como correspondente a um post se ambos compartilharem o mesmo ID.

2. **Instabilidade das Imagens:**
   O domínio onde as imagens da API são hospedadas apresenta instabilidades frequentes. O aplicativo possui tratamento de erros para exibir um ícone substituto caso o carregamento da imagem falhe.

3. **Limite de Dados:**
   Embora existam 5000 fotos, a API fornece apenas 100 posts e 100 álbuns. Para garantir a integridade dos dados cruzados (Foto + Post + Álbum), a listagem de fotos foi intencionalmente limitada aos primeiros 100 itens.

## Tecnologias Utilizadas

O projeto foi construído utilizando as seguintes bibliotecas e ferramentas:

- **Signals:** Gerenciamento de estado reativo.
- **Provider:** Injeção de dependências.
- **Dio e Native_Dio_Adapter:** Cliente HTTP otimizado para requisições nativas.
- **Url Launcher:** Implementação de Deep Linking (abertura de apps externos).
- **Logger:** Utilitário para logs e depuração.
- **String Similarity:** Algoritmo para filtragem e busca aproximada de texto.

## Estrutura do Projeto

A arquitetura do projeto segue o princípio de separação de responsabilidades em camadas distintas:

- **Domain:** Camada central que contém as Entidades e as regras de negócio da aplicação. É independente de bibliotecas externas ou frameworks.
- **Data:** Responsável pela comunicação com fontes externas. Lida com as requisições HTTP, implementação dos repositórios e conversão de JSON (Models).
- **Presentation:** Responsável pela Interface do Usuário (UI/UX), contendo as Páginas, Widgets e Controladores de estado.

## Funcionalidades Implementadas

- Listagem de fotos com paginação (Scroll Infinito).
- Busca de fotos com filtro por similaridade de texto.
- Visualização de detalhes com carregamento assíncrono de dados do Autor e Álbum.
- Integração com mapas: Abre a localização do autor no aplicativo de mapas padrão.
- Integração com e-mail: Abre o aplicativo de e-mail padrão com destinatário e assunto preenchidos.