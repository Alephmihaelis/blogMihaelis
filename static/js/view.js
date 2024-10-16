firebase.auth().onAuthStateChanged((user) => {
    if (user) {
    // Oculta o login
    $('#makeLogin').hide();

    // Preenche os campos NOME e EMAIL com os dados do usuário
    $('#commentName').val(user.displayName)
    $('#commentEmail').val(user.email);

    // Mostra o formulário de comentário
    $('#commentForm').show(); 
    } else {

    $('#commentName').val('')
    $('#commentEmail').val('');

    // Oculta o formulário de comentários
    $('#commentForm').hide();

    $('#makeLogin').show();
    }
  });