# Importa as dependências do aplicativo
from flask import Flask, redirect, render_template, request, url_for
from flask_mysqldb import MySQL, MySQLdb

# Importa as funções do banco de dados, tabela articles
from functions.db_articles import *
from functions.db_articles import update_views
from functions.db_articles import get_one
from functions.db_articles import get_more
from functions.db_articles import get_all
from functions.db_comments import *
from functions.db_comments import save_comment
from functions.db_comments import get_comments
from functions.db_contacts import save_contact


# Constantes do site
SITE = {
    'name': 'MihaBlog',
    'owner': 'Mihael',
    'logo': '/static/img/logo01.png',
    'favicon': '/static/img/logo01.png'
}

app = Flask(__name__)

# Configurações de acesso ao MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'mihablogdb'

# Configurações do servidor de e-mail
app.config['MAIL_SERVER'] = 'smtp-mail.outlook.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = ''
app.config['MAIL_PASSWORD'] = 'Senha123456'

mysql = MySQL(app)

@app.route('/')
def home():
    articles = get_all(mysql)
    toPage = {
        'site': SITE,
        'title': 'Página inicial',
        'css': 'home.css',
        'js': 'home.js',
        'articles': articles
    }
    return render_template('home.html', page=toPage)

@app.route('/view/<artid>')
def view(artid):
    # Se o ID do artigo não é número, mostra 404
    if not artid.isdigit():
        return page_not_found(404)
    
    # Obtém um artigo único
    article = get_one(mysql, artid)

    # Se o artigo não existe, mostra 404
    if article is None:
        return page_not_found(404)
    
    # Atualiza as visualizações do artigo
    update_views(mysql, artid)

    # Traduz o `type` do autor
    if article['sta_type'] == 'admin':
        article['sta_pt_type'] = 'Administrador(a)'
    elif article['sta_type'] == 'moderator':
        article['sta_pt_type'] = 'Moderador(a)'
    else:
        article['sta_pt_type'] = 'Autor'

    # Obtém mais artigos do author

    articles = get_more(mysql, article['sta_id'], article['art_id'], 4)

    # Somente o primeiro nome do autor
    article['sta_first'] = article['sta_name'].split()[0]

    # Obtém todos os comentários deste artigo

    comments = get_comments(mysql, article['art_id'])

    # Total de comentários

    total_comments = len(comments)

    toPage = {
        'site': SITE,
        'title': article['art_title'],
        'css': 'view.css',
        'article': article,
        'articles': articles,
        'comments': comments,
        'total_comments': total_comments
    }
    return render_template('view.html', page=toPage)

@app.route('/comment', methods=['POST'])
def comment():

    # Obtém dados do formulário
    form = request.form
    # Salva comentário no banco de dados
    save_comment(mysql, form)
    return redirect(f"{url_for('view', artid=form['artid'])}#comments")

@app.route('/contacts', methods=['GET', 'POST'])
def contacts():

    # Formulário enviado com sucesso
    success = False

    # Primeiro nome do remetente
    first_name = ''

    # Se o formulário foi enviado...
    if request.method == 'POST':
        # Obtém os dados do formulário
        form = dict(request.form)
        # Teste de mesa
        # print('\n\n\n', form, '\n\n\n')
        #     # Salva os dados no banco de dados
        sucess = save_contact(mysql, form)
        # Obtém o primeiro nome do remetente
        first_name = form['name'].split()[0]

    toPage = {
        'site': SITE,
        'title': 'Faça contato',
        'css': 'contacts.css',
        'success': success,
        'first_name': first_name
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

@app.errorhandler(404)
def page_not_found(e):
    toPage = {
        'title': 'Erro 404',
        'site': SITE,
        'css': '404.css'
    }
    return render_template('404.html', page=toPage), 404

@app.errorhandler(405)
def page_not_found(e):
    return 'Bizonhou!'


if __name__ == '__main__':
    app.run(debug=True)
