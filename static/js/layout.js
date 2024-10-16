
/* Conexão ao Firebase */
const firebaseConfig = {
    apiKey: "AIzaSyDISaGAAW3kAB9UfAKph7gWab4vAz8XuZ8",
    authDomain: "mihablog.firebaseapp.com",
    projectId: "mihablog",
    storageBucket: "mihablog.appspot.com",
    messagingSenderId: "290973996328",
    appId: "1:290973996328:web:d481e852c9992216e8ec1d"
  };

// Conexão com o Firebase usando os dados acima
const app = firebase.initializeApp(firebaseConfig);

// Seleciona o provedor de autenticação
var provider = new firebase.auth.GoogleAuthProvider();

firebase.auth().onAuthStateChanged((user) => {
    if (user) {
        // Troca a ação do botão para 'profile'
      $('#btnUser').attr({'data-action': 'profile'})
      // Troca para a imagem do usuário
      $('#btnUser').attr({
        'src': user.photoURL,
        'alt': user.displayName
      });
    } else {
          // Troca a ação do botão para 'login'
          $('#btnUser').attr({'data-action': 'login'})
          // Troca para a imagem do usuário
          $('#btnUser').attr({
            'src': 'static/img/user.png',
            'alt': 'Logue-se'
          });
    }
  });

// Fazendo login
function login() {
    // Faz login pelo Google usando popup
    firebase.auth().signInWithPopup(provider)
  }


// Fazendo logout
function logout() {
    firebase.auth().signOut()    
}


// Excluir conta do usuário
function userRemove() {
    const user = firebase.auth().currentUser;
    user.delete()
}

// Inicializa jQuery

$(document).ready(myApp);

// Aplicativo principal
function myApp() {

    // Monitora cliques no botão login/logout
    $('#btnUser').click(userToggle);
}

// Login / Logout do usuário

function userToggle() {
    // Lê o atributo 'data-action' do elemento #'btnUser'
    if ($('#btnUser').attr('data-action') == 'login') {
        
        // se for login, executa o login
        login()
    } else {

        // Temporário: faz logout
        // logout();

        // Mostra o perfil do usuário
        location.href ='/profile';
    }
}