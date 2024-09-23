
from flask import Flask

app = Flask(__name__)

# Rota para a página inicial
@app.route('/')
def home():
    htmlparams = {
        'title': 'Página inicial',
        'css': '/static/css/home.css',
        'js': '/static/js/home.js'
    }
    return 'Hello World!'


@app.route('/contact')
def contact():
    return 'Fale comigo!'


if __name__ == '__main__':
    app.run(debug=True)
