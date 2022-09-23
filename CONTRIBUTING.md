# Contribuíndo para o projeto

O documento que segue engloba diretrizes, instruções e recomendações
relacionadas ao desenvolvimento do projeto do escalonador de disciplinas.
Contribuições a este documento são sempre bem vindas.

## Configurando o ambiente

Para instalar uma versão interpretador [clingo](https://potassco.org/clingo/)
compatível com o código do projeto, pode-se usar a ferramenta de instalação de
pacotes Python [pip](https://pypi.org/project/pip/) da seguinte forma:

```bash
python -m pip install -r requirements.txt
```

Note que isso irá instalar as dependências do projeto globalmente para seu
usuário. Caso não queira contaminar seu ambiente pessoal, recomenda-se o uso de
um ambiente virtual, como o [venv](https://docs.python.org/3/library/venv.html):

```bash
# Cria o ambiente virtual na pasta oculta ".venv"
python -m venv .venv
# Ativa o ambiente e instala dependências
source .venv/bin/activate
pip install -r requirements.txt
```
