
# Importa as dependências do aplicativo
from flask import Flask, render_template

# Constantes do site
SITE = {    
     'NAME': 'blogMiha',
     'OWNER': '© Miha',
     'LOGO': '/static/img/logo.png'
}

# Cria uma aplicação Flask usando uma instância do Flask
app = Flask(__name__)

######################
# Rotas da aplicação #
######################

# Rota para a página inicial → raiz
@app.route('/')
def home():
    # Passa parâmetros para o template
    # CSS e JS são opcionais
    page = {
        'site': SITE,
        'title': '', # Título da página → <title></title>
        'css': 'home.css', # Folhas de estilo desta página (opcional)
        'js': 'home.js', # JavaScript desta página (opcional)
        # Outras chaves usadas pela página
        'coisas': ('Casa', 'Carro', 'Moto', 'Peteca')
    }
    # Renderizar = fazer a conversão do código Python em código HTML.
    return render_template('home.html', page=page)

@app.route('/contacts') # Rota para a página de contatos → /contacts
def contacts():
        page = {
        'site': SITE,
        'title': 'Contato',
        'css': 'home.css'
    }
        return render_template('contacts.html', page=page)

@app.route('/about')
def about():
     page = {
          'site': SITE,
          'title': 'Sobre nós',
          'css': 'about.css'
     }
     return render_template('about.html', page=page)

if __name__ == '__main__':
    app.run(debug=True)