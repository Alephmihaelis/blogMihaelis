
firebase.auth().onAuthStateChanged((user) => {
    // Se o usuário estiver logado
    if (user) {
        // Prenche o nome e o e-mail do usuário no formulário
        $('#name').val(user.displayName);
        $('#email').val(user.email)
    } else {
        $('#name').val('');
        $('#email').val('');
    }
  });