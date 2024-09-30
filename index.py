# Importa as dependências do aplicativo
from flask import Flask, render_template
from flask_mysqldb import MySQL, MySQLdb

# Constantes do site
SITE = {
    'name': 'MihaBlog',
    'owner': 'Mihael',
    'logo': '/static/img/logo.png',
    'favicon': '/static/img/logo.png'
}

# Cria uma aplicação Flask usando uma instância do Flask
app = Flask(__name__)

# Configurações de acesso ao MySQL
app.config['MYSQL_HOST'] = 'localhost'  # Servidor do MySQL
app.config['MYSQL_USER'] = 'root'       # Usuário do MySQL
app.config['MYSQL_PASSWORD'] = ''       # Senha do MYSQL
app.config['MYSQL_DB'] = 'mihablogdb'   # Nome do banco de dados

# Variável de conexão com o MySQL
mysql = MySQL(app) # Função sempre começam com letras minúsculas (como variáveis, etc.)
                    # Mas toda classe começa com letra maiúscula
                    # J. C. Martin, Código limpo (livro)

######################
# Rotas da aplicação #
######################

@app.route('/')  # Rota para a página inicial → raiz
def home():

    # Consulta SQL
    sql = '''
    -- Seleciona os campos abaixo
    SELECT art_id, art_title, art_resume, art_thumbnail
    -- desta tabela
    FROM article
    -- art status é 'on'
    WHERE art_status = 'on'
        -- e arte_date é menor ou igual à data atual
        -- não obtém artigos com data futura (agendados)
        AND art_date <= NOW()
    -- ordena pela ordem mais recente
    ORDER BY art_date DESC;
    '''

    # Executa a query e obtém os dados na forma de DICT
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql)
    articles = cur.fetchall()
    cur.close()

    # Somente para debug
#    print('\n\n\n', articles, '\n\n\n')

    # Passa parâmetros para o template
    # 'css' e 'js' são opcionais
    toPage = {
        # Título da página → <title></title>
        'site': SITE,
        'title': 'Página inicial',
        'css': 'home.css',  # Folhas de estilo desta página (opcional)
        'js': 'home.js',  # JavaScript desta página (opcional)
        # Outras chaves usadas pela página
        'articles': articles
    }

    # Renderiza template passando a variável local `toPage` para o template como `page`.
    return render_template('home.html', page=toPage)

@app.route('/view/<artid>') # Rota para a página que exibe o artigo completo
def view(artid):
    return artid


@app.route('/contacts')  # Rota para a página de contatos → /contacts
def contacts():

    toPage = {
        'site': SITE,
        'title': 'Faça contato',
        'css': 'home.css'
    }

    return render_template('contacts.html', page=toPage)


@app.route('/about')
def about():
    toPage = {
        'site': SITE,
        'title': 'Sobre',
        'css': 'about.css'
    }

    return render_template('about.html', page=toPage)



if __name__ == '__main__':
    app.run(debug=True)
