# ActiveB3

## ScreenShots da Aplicação

![image](https://i.ibb.co/mHdXrfD/1.png)
![image](https://i.ibb.co/cwZNhv1/2.png)
![image](https://i.ibb.co/f174KXK/3.png)

## Base Arquitetural


Este projeto utiliza como base arquitetural MVP (Model - View - Presenter). 

![image](https://i.ibb.co/6gqzZhk/Active-B3-Clean-Architecture-drawio-1.png)

Como complemento da arquitetura MVP, este projeto foi criado pensando que cada camada tivesse sua função bem definida, possibilitando assim a criação das camadas utilizando a abordagem de TDD (Test Driven Development) e alguns conceitos do SOLID (Como por exemplo o protocolo HttpClientGet, onde podemos aplicar o príncipio de "Interface Segregation Principle - ISP).

**Beneficios da arquitetura:**

Uma vez que cada camada possui sua função bem definida, eu posso por exemplo trocar a forma que a camada de infra faz chamadas HTTPS com o minimo de impacto e esforço dentro da aplicação. Outro benefício são os testes unitários (TU) presentes em cada camada, facilitando e garantindo a qualidade nas evoluções/mantutenções do código.


## Módulos da Aplicação. 


**Domain**

A Camada de Domain contem como responsabilidade manter todos os modelos de dados da Aplicação. 

**Data**

A Camada de Data contem como responsabilidade obter os dados de forma remota integrando com a camada de infra.

**Infra**

A Camada de Infra contem como responsabilidade criar e disponibilizar para a camada Data Meios de acessar os endpoints da API. Ela também mantem a integração com camadas externas, por exemplo Alamofire.

**Presentation**

A camada Presenter contem como responsabilidade orquestrar a obteção dos dados e notificar da camada de UI para apresentação dos dados.

**UI**

A camda UI contem como responsabilidade fornecer os componentes e recursos para criação de Layouts. Ela também mantem a integração com a camada de bibliotécas de componentes, por exemplo UIKit.

**Validation**

A camada Validation contem como responsabilidade realizar todas validações que a camada de UI necessita na entrada de dados na aplicação.

**Main**

AppDelegate, SceneDelegate e Info.Plist

Nessa camada, podemos destacar algumas classes de padrões de projeto utilizadas no projeto:

- ValidationBuilder: Padrão de projeto (Builder) para facilitar a junção de várias validações (Validation) utilizando da concatenação dos métodos.
- MainQueueDispatchDecorator: Padrão de projeto (Decorator) para adicionar responsabilidade de execução de assincrona na Thread principal por evolver atualização de componentes de UI.
- WeakVarProxy: Padrão de projeto (Proxy) para remover referência ciclica e evitar memory leak ao inserir uma camada com referência fraca entre os objetos.

## Alamofire

**Link:** https://github.com/Alamofire/Alamofire

**Função:** Alamofire é uma biblioteca de rede HTTP.

**Como foi utilizado?:** Parar criar a camada de serviço e abstrair algumas funções dos Services, o Alamofire é utilizado em todas as requisições

