-- -------------------------------- --
-- Banco de dados 'blogMihaelis' --
-- -------------------------------- --

-- Apaga o banco de dados caso ele já exista. --
-- PERIGO! Não fçaa isso em modo de produção (i. e., quando o site estiver na internet) --

DROP DATABASE IF EXISTS blogMihaelis;

-- Cria o banco de dados novamente --
-- PERIGO! Não faça isso em modo de produção --
CREATE DATABASE blogMihaelis
    
    -- Usando o conjunto de caracteres UTF-8 --
    CHARACTER SET utf8mb4

    -- Buscas em UFT-8 e case insensitive --
    COLLATE utf8mb4_general_ci;

    -- Seleciona o banco de dados para os próximos comandos --
    USE blogMihaelis;

    -- Cria a tabela 'staff' --
    CREATE TABLE staff (
        sta_id INT PRIMARY KEY AUTO_INCREMENT,
        sta_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        sta_name VARCHAR(127) NOT NULL,
        sta_email VARCHAR(255) NOT NULL,
        sta_password VARCHAR(63) NOT NULL,
        sta_birth DATE NOT NULL,
        sta_image VARCHAR(255) NOT NULL,
        sta_description VARCHAR(255),
        sta_type ENUM('moderator', 'author', 'admin') DEFAULT 'moderator',
        sta_status ENUM('on', 'off', 'del') DEFAULT 'on'
    );

    CREATE TABLE article (
        art_id INT PRIMARY KEY AUTO_INCREMENT,
        art_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        art_title VARCHAR(127) NOT NULL,
        art_resume VARCHAR(255) NOT NULL,
        art_thumbnail VARCHAR(255) NOT NULL,
        art_content TEXT NOT NULL,
        art_view INT DEFAULT 0,
        art_author INT,
        art_status ENUM('on', 'off', 'del') DEFAULT 'on',
        -- Chave estrangeira para 'staff' 
        FOREIGN KEY (art_author) REFERENCES staff (sta_id)
    );

    CREATE TABLE comment (
        com_id INT PRIMARY KEY AUTO_INCREMENT,
        com_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        com_article INT NOT NULL,
        com_author_name VARCHAR(127) NOT NULL,
        com_author_email VARCHAR(255) NOT NULL,
        com_comment TEXT NOT NULL,
        com_status ENUM('on', 'off', 'del') DEFAULT 'on',
        -- Chave estrangeira para 'article'
        FOREIGN KEY (com_article) REFERENCES article (art_id)
    );

    -- Cria a tabela 'contact'
    CREATE TABLE contact (
        id INT PRIMARY KEY AUTO_INCREMENT,
        date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        name VARCHAR(127) NOT NULL,
        email VARCHAR(255) NOT NULL,
        subject VARCHAR(255) NOT NULL,
        message TEXT,
        status ENUM('received', 'responded', 'deleted') DEFAULT 'received'
    );

-- Popula (põe dados) as tabelas com alguns dados 'fake' --
-- Tabela 'staff'
INSERT INTO staff (
        sta_name,
        sta_email,
        sta_password,
        sta_birth,
        sta_image,
        sta_description,
        sta_type
) VALUES (
    'Fulaninho Beltrão',
    'beltrao@fulano.com',
    SHA1('Senha123456'),
    '2000-03-27',
    'https://randomuser.me/api/portraits/men/85.jpg',
    'Programador, escultor, pintor, preparador e enrolador',
    'admin'
), (
    'Marineuza Creuza',
    'mari@creuza.com',
    SHA1('Senha123456'),
    '1999-08-14',
    'https://randomuser.me/api/portraits/women/20.jpg',
    'Programadora, arrumadora, doida',
    'author'
), (
    'Ana Costa',
    'ana@exemplo.com',
    SHA1('Senha123456'),
    '1990-02-14',
    'https://randomuser.me/api/portraits/women/21.jpg',
    'Escritora, blogueira',
    'author'
), (
    'Ricardo Santos',
    'ricardo@exemplo.com',
    SHA1('Senha123456'),
    '1985-11-23',
    'https://randomuser.me/api/portraits/men/0.jpg',
    'Moderador, gamer',
    'moderator'
), (
    'Laura Almeida',
    'laura@exemplo.com',
    SHA1('Senha123456'),
    '1998-06-09',
    'https://randomuser.me/api/portraits/women/22.jpg',
    'Artista, dançarina',
    'author'
), (
    'Felipe Lima',
    'felipe@exemplo.com',
    SHA1('Senha123456'),
    '1983-04-30',
    'https://randomuser.me/api/portraits/men/28.jpg',
    'Editor, crítico de cinema',
    'moderator'
), (
    'Juliana Martins',
    'juliana@exemplo.com',
    SHA1('Senha123456'),
    '1995-08-21',
    'https://randomuser.me/api/portraits/women/23.jpg',
    'Fotógrafa, viajante',
    'author'
);

-- Inserção na tabela article
INSERT INTO article (
        art_title,
        art_resume,
        art_thumbnail,
        art_content,
        art_author
) VALUES (
    'Primeiro artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit',
    'https://picsum.photos/300',
    '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artigo fake</title>
</head>
<body>
    
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate corrupti molestiae velit quia eaque eum accusantium ipsam ad? At, neque sint, hic architecto nemo, suscipit corporis vero assumenda adipisci accusamus illo explicabo quia? Optio impedit id ut eos facilis accusamus, sint quos, labore distinctio modi consectetur iure voluptatibus, necessitatibus soluta dolore explicabo obcaecati ea consequuntur eius repellendus dolorum doloremque! Earum amet minima esse deserunt cum ipsam corrupti suscipit non, dolore tempore at illo blanditiis eius, rerum quo! Exercitationem ad corporis consequatur. Omnis aliquid soluta aliquam pariatur nemo quos eos iure totam laboriosam impedit et natus reprehenderit repellat corrupti porro ducimus quisquam ratione, modi ipsa, maxime enim numquam veritatis laudantium voluptas. Praesentium animi quos inventore incidunt eius delectus voluptatum doloribus quasi. Odit quia iure inventore eligendi a optio dolorum doloremque tempora commodi rem! Ipsa exercitationem rerum minima expedita est. Quaerat quo ipsum mollitia perferendis harum eveniet numquam maxime aliquid inventore culpa veritatis reprehenderit amet dolor tempore odio, est cumque ullam ipsa cum fuga saepe nam deserunt tenetur. Sunt, eum nihil quod, blanditiis sequi doloribus cupiditate corrupti aliquid incidunt, voluptas voluptatum atque impedit quisquam fuga eos porro quia ad aut dicta vero voluptatem ipsa repudiandae unde. Eius iure consequatur nam natus provident, labore impedit sapiente sunt officia unde? Aspernatur molestiae quo odio quas vel iste a eum ullam cupiditate est, laborum quasi exercitationem ad, maiores nam! Voluptate recusandae corrupti omnis ullam est maiores suscipit aperiam tempora mollitia, dicta nobis dolores, nulla asperiores laborum commodi praesentium. Nihil minima qui repudiandae pariatur, quos, at ad quasi facere ullam, id magnam non! Eius repellendus cupiditate vero ea beatae delectus adipisci iusto non nisi aspernatur quasi consequatur corporis eos id voluptate excepturi odit doloremque, maiores ipsa accusamus deleniti est hic! Eveniet, assumenda expedita? Quaerat numquam velit, modi reiciendis assumenda nemo porro optio esse corrupti tenetur repudiandae!</p>
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae quisquam explicabo temporibus delectus aliquam, doloribus minus quo totam dolores cupiditate perspiciatis. Atque dicta, ab laborum dolor culpa consectetur nulla voluptatibus.</p>
<img src="../database/modelo_da_tabela.PNG" alt="Imagem do banco de dados" title="Imagem do banco de dados">
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iusto quos corporis assumenda saepe ratione voluptatibus eius quam enim, error sunt excepturi vitae architecto accusantium rem in, illum alias repudiandae autem consequuntur pariatur. Placeat est veritatis doloribus ut provident accusantium, necessitatibus rerum molestias at facilis commodi? Mollitia maxime ipsa facere cumque sunt pariatur sint harum odit nisi optio. Illum ut, molestiae cupiditate minus corrupti voluptatibus nihil, rerum placeat fugit nesciunt repudiandae. Cupiditate voluptas mollitia recusandae ipsam adipisci cumque, ducimus vitae, dolor eum quidem expedita, praesentium impedit qui voluptatem! A voluptatibus nostrum consequuntur omnis ea! Maiores veniam alias tempore obcaecati iure placeat.</p>
<h4>Lista de links:</h4>
<ul>
    <li><a href="google.com" target="_blank">Google</a></li>
    <li><a href="youtube.com" target="_blank">YouTube</a></li>
    <li><a href="github.com" target="_blank">GitHub</a></li>
    <li><a href="instagram.com" target="_blank">Instagram</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Itaque adipisci cum esse ad. Et corporis corrupti maxime neque suscipit sequi aliquid eos minus voluptate harum nobis repellendus amet, rerum eius recusandae illum. Explicabo perspiciatis laudantium, distinctio eum blanditiis aut ipsam ipsa, nobis recusandae eius impedit nihil dolor illum quam soluta dolorum vitae accusantium, at ea? Totam ipsum quibusdam odio nihil nesciunt, assumenda quas obcaecati suscipit delectus ab dolor, earum dolores nemo fugiat maxime voluptas sit voluptates perspiciatis sunt quo. Aliquam odit itaque non quas repudiandae asperiores quaerat commodi odio vel.</p>

</body>
</html>',
    '2'
), (
    'Segundo artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit',
    'https://picsum.photos/301',
    '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artigo fake</title>
</head>
<body>
    
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate corrupti molestiae velit quia eaque eum accusantium ipsam ad? At, neque sint, hic architecto nemo, suscipit corporis vero assumenda adipisci accusamus illo explicabo quia? Optio impedit id ut eos facilis accusamus, sint quos, labore distinctio modi consectetur iure voluptatibus, necessitatibus soluta dolore explicabo obcaecati ea consequuntur eius repellendus dolorum doloremque! Earum amet minima esse deserunt cum ipsam corrupti suscipit non, dolore tempore at illo blanditiis eius, rerum quo! Exercitationem ad corporis consequatur. Omnis aliquid soluta aliquam pariatur nemo quos eos iure totam laboriosam impedit et natus reprehenderit repellat corrupti porro ducimus quisquam ratione, modi ipsa, maxime enim numquam veritatis laudantium voluptas. Praesentium animi quos inventore incidunt eius delectus voluptatum doloribus quasi. Odit quia iure inventore eligendi a optio dolorum doloremque tempora commodi rem! Ipsa exercitationem rerum minima expedita est. Quaerat quo ipsum mollitia perferendis harum eveniet numquam maxime aliquid inventore culpa veritatis reprehenderit amet dolor tempore odio, est cumque ullam ipsa cum fuga saepe nam deserunt tenetur. Sunt, eum nihil quod, blanditiis sequi doloribus cupiditate corrupti aliquid incidunt, voluptas voluptatum atque impedit quisquam fuga eos porro quia ad aut dicta vero voluptatem ipsa repudiandae unde. Eius iure consequatur nam natus provident, labore impedit sapiente sunt officia unde? Aspernatur molestiae quo odio quas vel iste a eum ullam cupiditate est, laborum quasi exercitationem ad, maiores nam! Voluptate recusandae corrupti omnis ullam est maiores suscipit aperiam tempora mollitia, dicta nobis dolores, nulla asperiores laborum commodi praesentium. Nihil minima qui repudiandae pariatur, quos, at ad quasi facere ullam, id magnam non! Eius repellendus cupiditate vero ea beatae delectus adipisci iusto non nisi aspernatur quasi consequatur corporis eos id voluptate excepturi odit doloremque, maiores ipsa accusamus deleniti est hic! Eveniet, assumenda expedita? Quaerat numquam velit, modi reiciendis assumenda nemo porro optio esse corrupti tenetur repudiandae!</p>
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae quisquam explicabo temporibus delectus aliquam, doloribus minus quo totam dolores cupiditate perspiciatis. Atque dicta, ab laborum dolor culpa consectetur nulla voluptatibus.</p>
<img src="../database/modelo_da_tabela.PNG" alt="Imagem do banco de dados" title="Imagem do banco de dados">
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iusto quos corporis assumenda saepe ratione voluptatibus eius quam enim, error sunt excepturi vitae architecto accusantium rem in, illum alias repudiandae autem consequuntur pariatur. Placeat est veritatis doloribus ut provident accusantium, necessitatibus rerum molestias at facilis commodi? Mollitia maxime ipsa facere cumque sunt pariatur sint harum odit nisi optio. Illum ut, molestiae cupiditate minus corrupti voluptatibus nihil, rerum placeat fugit nesciunt repudiandae. Cupiditate voluptas mollitia recusandae ipsam adipisci cumque, ducimus vitae, dolor eum quidem expedita, praesentium impedit qui voluptatem! A voluptatibus nostrum consequuntur omnis ea! Maiores veniam alias tempore obcaecati iure placeat.</p>
<h4>Lista de links:</h4>
<ul>
    <li><a href="google.com" target="_blank">Google</a></li>
    <li><a href="youtube.com" target="_blank">YouTube</a></li>
    <li><a href="github.com" target="_blank">GitHub</a></li>
    <li><a href="instagram.com" target="_blank">Instagram</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Itaque adipisci cum esse ad. Et corporis corrupti maxime neque suscipit sequi aliquid eos minus voluptate harum nobis repellendus amet, rerum eius recusandae illum. Explicabo perspiciatis laudantium, distinctio eum blanditiis aut ipsam ipsa, nobis recusandae eius impedit nihil dolor illum quam soluta dolorum vitae accusantium, at ea? Totam ipsum quibusdam odio nihil nesciunt, assumenda quas obcaecati suscipit delectus ab dolor, earum dolores nemo fugiat maxime voluptas sit voluptates perspiciatis sunt quo. Aliquam odit itaque non quas repudiandae asperiores quaerat commodi odio vel.</p>

</body>
</html>',
    '1'
), (
    'Terceiro artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit',
    'https://picsum.photos/302',
    '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artigo fake</title>
</head>
<body>
    
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate corrupti molestiae velit quia eaque eum accusantium ipsam ad? At, neque sint, hic architecto nemo, suscipit corporis vero assumenda adipisci accusamus illo explicabo quia? Optio impedit id ut eos facilis accusamus, sint quos, labore distinctio modi consectetur iure voluptatibus, necessitatibus soluta dolore explicabo obcaecati ea consequuntur eius repellendus dolorum doloremque! Earum amet minima esse deserunt cum ipsam corrupti suscipit non, dolore tempore at illo blanditiis eius, rerum quo! Exercitationem ad corporis consequatur. Omnis aliquid soluta aliquam pariatur nemo quos eos iure totam laboriosam impedit et natus reprehenderit repellat corrupti porro ducimus quisquam ratione, modi ipsa, maxime enim numquam veritatis laudantium voluptas. Praesentium animi quos inventore incidunt eius delectus voluptatum doloribus quasi. Odit quia iure inventore eligendi a optio dolorum doloremque tempora commodi rem! Ipsa exercitationem rerum minima expedita est. Quaerat quo ipsum mollitia perferendis harum eveniet numquam maxime aliquid inventore culpa veritatis reprehenderit amet dolor tempore odio, est cumque ullam ipsa cum fuga saepe nam deserunt tenetur. Sunt, eum nihil quod, blanditiis sequi doloribus cupiditate corrupti aliquid incidunt, voluptas voluptatum atque impedit quisquam fuga eos porro quia ad aut dicta vero voluptatem ipsa repudiandae unde. Eius iure consequatur nam natus provident, labore impedit sapiente sunt officia unde? Aspernatur molestiae quo odio quas vel iste a eum ullam cupiditate est, laborum quasi exercitationem ad, maiores nam! Voluptate recusandae corrupti omnis ullam est maiores suscipit aperiam tempora mollitia, dicta nobis dolores, nulla asperiores laborum commodi praesentium. Nihil minima qui repudiandae pariatur, quos, at ad quasi facere ullam, id magnam non! Eius repellendus cupiditate vero ea beatae delectus adipisci iusto non nisi aspernatur quasi consequatur corporis eos id voluptate excepturi odit doloremque, maiores ipsa accusamus deleniti est hic! Eveniet, assumenda expedita? Quaerat numquam velit, modi reiciendis assumenda nemo porro optio esse corrupti tenetur repudiandae!</p>
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae quisquam explicabo temporibus delectus aliquam, doloribus minus quo totam dolores cupiditate perspiciatis. Atque dicta, ab laborum dolor culpa consectetur nulla voluptatibus.</p>
<img src="../database/modelo_da_tabela.PNG" alt="Imagem do banco de dados" title="Imagem do banco de dados">
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iusto quos corporis assumenda saepe ratione voluptatibus eius quam enim, error sunt excepturi vitae architecto accusantium rem in, illum alias repudiandae autem consequuntur pariatur. Placeat est veritatis doloribus ut provident accusantium, necessitatibus rerum molestias at facilis commodi? Mollitia maxime ipsa facere cumque sunt pariatur sint harum odit nisi optio. Illum ut, molestiae cupiditate minus corrupti voluptatibus nihil, rerum placeat fugit nesciunt repudiandae. Cupiditate voluptas mollitia recusandae ipsam adipisci cumque, ducimus vitae, dolor eum quidem expedita, praesentium impedit qui voluptatem! A voluptatibus nostrum consequuntur omnis ea! Maiores veniam alias tempore obcaecati iure placeat.</p>
<h4>Lista de links:</h4>
<ul>
    <li><a href="google.com" target="_blank">Google</a></li>
    <li><a href="youtube.com" target="_blank">YouTube</a></li>
    <li><a href="github.com" target="_blank">GitHub</a></li>
    <li><a href="instagram.com" target="_blank">Instagram</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Itaque adipisci cum esse ad. Et corporis corrupti maxime neque suscipit sequi aliquid eos minus voluptate harum nobis repellendus amet, rerum eius recusandae illum. Explicabo perspiciatis laudantium, distinctio eum blanditiis aut ipsam ipsa, nobis recusandae eius impedit nihil dolor illum quam soluta dolorum vitae accusantium, at ea? Totam ipsum quibusdam odio nihil nesciunt, assumenda quas obcaecati suscipit delectus ab dolor, earum dolores nemo fugiat maxime voluptas sit voluptates perspiciatis sunt quo. Aliquam odit itaque non quas repudiandae asperiores quaerat commodi odio vel.</p>

</body>
</html>',
    '3'
), (
    'Quarto artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit',
    'https://picsum.photos/304',
    '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artigo fake</title>
</head>
<body>
    
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate corrupti molestiae velit quia eaque eum accusantium ipsam ad? At, neque sint, hic architecto nemo, suscipit corporis vero assumenda adipisci accusamus illo explicabo quia? Optio impedit id ut eos facilis accusamus, sint quos, labore distinctio modi consectetur iure voluptatibus, necessitatibus soluta dolore explicabo obcaecati ea consequuntur eius repellendus dolorum doloremque! Earum amet minima esse deserunt cum ipsam corrupti suscipit non, dolore tempore at illo blanditiis eius, rerum quo! Exercitationem ad corporis consequatur. Omnis aliquid soluta aliquam pariatur nemo quos eos iure totam laboriosam impedit et natus reprehenderit repellat corrupti porro ducimus quisquam ratione, modi ipsa, maxime enim numquam veritatis laudantium voluptas. Praesentium animi quos inventore incidunt eius delectus voluptatum doloribus quasi. Odit quia iure inventore eligendi a optio dolorum doloremque tempora commodi rem! Ipsa exercitationem rerum minima expedita est. Quaerat quo ipsum mollitia perferendis harum eveniet numquam maxime aliquid inventore culpa veritatis reprehenderit amet dolor tempore odio, est cumque ullam ipsa cum fuga saepe nam deserunt tenetur. Sunt, eum nihil quod, blanditiis sequi doloribus cupiditate corrupti aliquid incidunt, voluptas voluptatum atque impedit quisquam fuga eos porro quia ad aut dicta vero voluptatem ipsa repudiandae unde. Eius iure consequatur nam natus provident, labore impedit sapiente sunt officia unde? Aspernatur molestiae quo odio quas vel iste a eum ullam cupiditate est, laborum quasi exercitationem ad, maiores nam! Voluptate recusandae corrupti omnis ullam est maiores suscipit aperiam tempora mollitia, dicta nobis dolores, nulla asperiores laborum commodi praesentium. Nihil minima qui repudiandae pariatur, quos, at ad quasi facere ullam, id magnam non! Eius repellendus cupiditate vero ea beatae delectus adipisci iusto non nisi aspernatur quasi consequatur corporis eos id voluptate excepturi odit doloremque, maiores ipsa accusamus deleniti est hic! Eveniet, assumenda expedita? Quaerat numquam velit, modi reiciendis assumenda nemo porro optio esse corrupti tenetur repudiandae!</p>
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae quisquam explicabo temporibus delectus aliquam, doloribus minus quo totam dolores cupiditate perspiciatis. Atque dicta, ab laborum dolor culpa consectetur nulla voluptatibus.</p>
<img src="../database/modelo_da_tabela.PNG" alt="Imagem do banco de dados" title="Imagem do banco de dados">
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iusto quos corporis assumenda saepe ratione voluptatibus eius quam enim, error sunt excepturi vitae architecto accusantium rem in, illum alias repudiandae autem consequuntur pariatur. Placeat est veritatis doloribus ut provident accusantium, necessitatibus rerum molestias at facilis commodi? Mollitia maxime ipsa facere cumque sunt pariatur sint harum odit nisi optio. Illum ut, molestiae cupiditate minus corrupti voluptatibus nihil, rerum placeat fugit nesciunt repudiandae. Cupiditate voluptas mollitia recusandae ipsam adipisci cumque, ducimus vitae, dolor eum quidem expedita, praesentium impedit qui voluptatem! A voluptatibus nostrum consequuntur omnis ea! Maiores veniam alias tempore obcaecati iure placeat.</p>
<h4>Lista de links:</h4>
<ul>
    <li><a href="google.com" target="_blank">Google</a></li>
    <li><a href="youtube.com" target="_blank">YouTube</a></li>
    <li><a href="github.com" target="_blank">GitHub</a></li>
    <li><a href="instagram.com" target="_blank">Instagram</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Itaque adipisci cum esse ad. Et corporis corrupti maxime neque suscipit sequi aliquid eos minus voluptate harum nobis repellendus amet, rerum eius recusandae illum. Explicabo perspiciatis laudantium, distinctio eum blanditiis aut ipsam ipsa, nobis recusandae eius impedit nihil dolor illum quam soluta dolorum vitae accusantium, at ea? Totam ipsum quibusdam odio nihil nesciunt, assumenda quas obcaecati suscipit delectus ab dolor, earum dolores nemo fugiat maxime voluptas sit voluptates perspiciatis sunt quo. Aliquam odit itaque non quas repudiandae asperiores quaerat commodi odio vel.</p>

</body>
</html>',
    '4'
), (
    'Quinto artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit',
    'https://picsum.photos/305',
    '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artigo fake</title>
</head>
<body>
    
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate corrupti molestiae velit quia eaque eum accusantium ipsam ad? At, neque sint, hic architecto nemo, suscipit corporis vero assumenda adipisci accusamus illo explicabo quia? Optio impedit id ut eos facilis accusamus, sint quos, labore distinctio modi consectetur iure voluptatibus, necessitatibus soluta dolore explicabo obcaecati ea consequuntur eius repellendus dolorum doloremque! Earum amet minima esse deserunt cum ipsam corrupti suscipit non, dolore tempore at illo blanditiis eius, rerum quo! Exercitationem ad corporis consequatur. Omnis aliquid soluta aliquam pariatur nemo quos eos iure totam laboriosam impedit et natus reprehenderit repellat corrupti porro ducimus quisquam ratione, modi ipsa, maxime enim numquam veritatis laudantium voluptas. Praesentium animi quos inventore incidunt eius delectus voluptatum doloribus quasi. Odit quia iure inventore eligendi a optio dolorum doloremque tempora commodi rem! Ipsa exercitationem rerum minima expedita est. Quaerat quo ipsum mollitia perferendis harum eveniet numquam maxime aliquid inventore culpa veritatis reprehenderit amet dolor tempore odio, est cumque ullam ipsa cum fuga saepe nam deserunt tenetur. Sunt, eum nihil quod, blanditiis sequi doloribus cupiditate corrupti aliquid incidunt, voluptas voluptatum atque impedit quisquam fuga eos porro quia ad aut dicta vero voluptatem ipsa repudiandae unde. Eius iure consequatur nam natus provident, labore impedit sapiente sunt officia unde? Aspernatur molestiae quo odio quas vel iste a eum ullam cupiditate est, laborum quasi exercitationem ad, maiores nam! Voluptate recusandae corrupti omnis ullam est maiores suscipit aperiam tempora mollitia, dicta nobis dolores, nulla asperiores laborum commodi praesentium. Nihil minima qui repudiandae pariatur, quos, at ad quasi facere ullam, id magnam non! Eius repellendus cupiditate vero ea beatae delectus adipisci iusto non nisi aspernatur quasi consequatur corporis eos id voluptate excepturi odit doloremque, maiores ipsa accusamus deleniti est hic! Eveniet, assumenda expedita? Quaerat numquam velit, modi reiciendis assumenda nemo porro optio esse corrupti tenetur repudiandae!</p>
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae quisquam explicabo temporibus delectus aliquam, doloribus minus quo totam dolores cupiditate perspiciatis. Atque dicta, ab laborum dolor culpa consectetur nulla voluptatibus.</p>
<img src="../database/modelo_da_tabela.PNG" alt="Imagem do banco de dados" title="Imagem do banco de dados">
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iusto quos corporis assumenda saepe ratione voluptatibus eius quam enim, error sunt excepturi vitae architecto accusantium rem in, illum alias repudiandae autem consequuntur pariatur. Placeat est veritatis doloribus ut provident accusantium, necessitatibus rerum molestias at facilis commodi? Mollitia maxime ipsa facere cumque sunt pariatur sint harum odit nisi optio. Illum ut, molestiae cupiditate minus corrupti voluptatibus nihil, rerum placeat fugit nesciunt repudiandae. Cupiditate voluptas mollitia recusandae ipsam adipisci cumque, ducimus vitae, dolor eum quidem expedita, praesentium impedit qui voluptatem! A voluptatibus nostrum consequuntur omnis ea! Maiores veniam alias tempore obcaecati iure placeat.</p>
<h4>Lista de links:</h4>
<ul>
    <li><a href="google.com" target="_blank">Google</a></li>
    <li><a href="youtube.com" target="_blank">YouTube</a></li>
    <li><a href="github.com" target="_blank">GitHub</a></li>
    <li><a href="instagram.com" target="_blank">Instagram</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Itaque adipisci cum esse ad. Et corporis corrupti maxime neque suscipit sequi aliquid eos minus voluptate harum nobis repellendus amet, rerum eius recusandae illum. Explicabo perspiciatis laudantium, distinctio eum blanditiis aut ipsam ipsa, nobis recusandae eius impedit nihil dolor illum quam soluta dolorum vitae accusantium, at ea? Totam ipsum quibusdam odio nihil nesciunt, assumenda quas obcaecati suscipit delectus ab dolor, earum dolores nemo fugiat maxime voluptas sit voluptates perspiciatis sunt quo. Aliquam odit itaque non quas repudiandae asperiores quaerat commodi odio vel.</p>

</body>
</html>',
    '3'
), (
    'Sexto artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit',
    'https://picsum.photos/306',
    '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artigo fake</title>
</head>
<body>
    
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate corrupti molestiae velit quia eaque eum accusantium ipsam ad? At, neque sint, hic architecto nemo, suscipit corporis vero assumenda adipisci accusamus illo explicabo quia? Optio impedit id ut eos facilis accusamus, sint quos, labore distinctio modi consectetur iure voluptatibus, necessitatibus soluta dolore explicabo obcaecati ea consequuntur eius repellendus dolorum doloremque! Earum amet minima esse deserunt cum ipsam corrupti suscipit non, dolore tempore at illo blanditiis eius, rerum quo! Exercitationem ad corporis consequatur. Omnis aliquid soluta aliquam pariatur nemo quos eos iure totam laboriosam impedit et natus reprehenderit repellat corrupti porro ducimus quisquam ratione, modi ipsa, maxime enim numquam veritatis laudantium voluptas. Praesentium animi quos inventore incidunt eius delectus voluptatum doloribus quasi. Odit quia iure inventore eligendi a optio dolorum doloremque tempora commodi rem! Ipsa exercitationem rerum minima expedita est. Quaerat quo ipsum mollitia perferendis harum eveniet numquam maxime aliquid inventore culpa veritatis reprehenderit amet dolor tempore odio, est cumque ullam ipsa cum fuga saepe nam deserunt tenetur. Sunt, eum nihil quod, blanditiis sequi doloribus cupiditate corrupti aliquid incidunt, voluptas voluptatum atque impedit quisquam fuga eos porro quia ad aut dicta vero voluptatem ipsa repudiandae unde. Eius iure consequatur nam natus provident, labore impedit sapiente sunt officia unde? Aspernatur molestiae quo odio quas vel iste a eum ullam cupiditate est, laborum quasi exercitationem ad, maiores nam! Voluptate recusandae corrupti omnis ullam est maiores suscipit aperiam tempora mollitia, dicta nobis dolores, nulla asperiores laborum commodi praesentium. Nihil minima qui repudiandae pariatur, quos, at ad quasi facere ullam, id magnam non! Eius repellendus cupiditate vero ea beatae delectus adipisci iusto non nisi aspernatur quasi consequatur corporis eos id voluptate excepturi odit doloremque, maiores ipsa accusamus deleniti est hic! Eveniet, assumenda expedita? Quaerat numquam velit, modi reiciendis assumenda nemo porro optio esse corrupti tenetur repudiandae!</p>
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae quisquam explicabo temporibus delectus aliquam, doloribus minus quo totam dolores cupiditate perspiciatis. Atque dicta, ab laborum dolor culpa consectetur nulla voluptatibus.</p>
<img src="../database/modelo_da_tabela.PNG" alt="Imagem do banco de dados" title="Imagem do banco de dados">
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iusto quos corporis assumenda saepe ratione voluptatibus eius quam enim, error sunt excepturi vitae architecto accusantium rem in, illum alias repudiandae autem consequuntur pariatur. Placeat est veritatis doloribus ut provident accusantium, necessitatibus rerum molestias at facilis commodi? Mollitia maxime ipsa facere cumque sunt pariatur sint harum odit nisi optio. Illum ut, molestiae cupiditate minus corrupti voluptatibus nihil, rerum placeat fugit nesciunt repudiandae. Cupiditate voluptas mollitia recusandae ipsam adipisci cumque, ducimus vitae, dolor eum quidem expedita, praesentium impedit qui voluptatem! A voluptatibus nostrum consequuntur omnis ea! Maiores veniam alias tempore obcaecati iure placeat.</p>
<h4>Lista de links:</h4>
<ul>
    <li><a href="google.com" target="_blank">Google</a></li>
    <li><a href="youtube.com" target="_blank">YouTube</a></li>
    <li><a href="github.com" target="_blank">GitHub</a></li>
    <li><a href="instagram.com" target="_blank">Instagram</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Itaque adipisci cum esse ad. Et corporis corrupti maxime neque suscipit sequi aliquid eos minus voluptate harum nobis repellendus amet, rerum eius recusandae illum. Explicabo perspiciatis laudantium, distinctio eum blanditiis aut ipsam ipsa, nobis recusandae eius impedit nihil dolor illum quam soluta dolorum vitae accusantium, at ea? Totam ipsum quibusdam odio nihil nesciunt, assumenda quas obcaecati suscipit delectus ab dolor, earum dolores nemo fugiat maxime voluptas sit voluptates perspiciatis sunt quo. Aliquam odit itaque non quas repudiandae asperiores quaerat commodi odio vel.</p>

</body>
</html>',
    '7'
), (
    'Sétimo artigo',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit',
    'https://picsum.photos/307',
    '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artigo fake</title>
</head>
<body>
    
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate corrupti molestiae velit quia eaque eum accusantium ipsam ad? At, neque sint, hic architecto nemo, suscipit corporis vero assumenda adipisci accusamus illo explicabo quia? Optio impedit id ut eos facilis accusamus, sint quos, labore distinctio modi consectetur iure voluptatibus, necessitatibus soluta dolore explicabo obcaecati ea consequuntur eius repellendus dolorum doloremque! Earum amet minima esse deserunt cum ipsam corrupti suscipit non, dolore tempore at illo blanditiis eius, rerum quo! Exercitationem ad corporis consequatur. Omnis aliquid soluta aliquam pariatur nemo quos eos iure totam laboriosam impedit et natus reprehenderit repellat corrupti porro ducimus quisquam ratione, modi ipsa, maxime enim numquam veritatis laudantium voluptas. Praesentium animi quos inventore incidunt eius delectus voluptatum doloribus quasi. Odit quia iure inventore eligendi a optio dolorum doloremque tempora commodi rem! Ipsa exercitationem rerum minima expedita est. Quaerat quo ipsum mollitia perferendis harum eveniet numquam maxime aliquid inventore culpa veritatis reprehenderit amet dolor tempore odio, est cumque ullam ipsa cum fuga saepe nam deserunt tenetur. Sunt, eum nihil quod, blanditiis sequi doloribus cupiditate corrupti aliquid incidunt, voluptas voluptatum atque impedit quisquam fuga eos porro quia ad aut dicta vero voluptatem ipsa repudiandae unde. Eius iure consequatur nam natus provident, labore impedit sapiente sunt officia unde? Aspernatur molestiae quo odio quas vel iste a eum ullam cupiditate est, laborum quasi exercitationem ad, maiores nam! Voluptate recusandae corrupti omnis ullam est maiores suscipit aperiam tempora mollitia, dicta nobis dolores, nulla asperiores laborum commodi praesentium. Nihil minima qui repudiandae pariatur, quos, at ad quasi facere ullam, id magnam non! Eius repellendus cupiditate vero ea beatae delectus adipisci iusto non nisi aspernatur quasi consequatur corporis eos id voluptate excepturi odit doloremque, maiores ipsa accusamus deleniti est hic! Eveniet, assumenda expedita? Quaerat numquam velit, modi reiciendis assumenda nemo porro optio esse corrupti tenetur repudiandae!</p>
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quae quisquam explicabo temporibus delectus aliquam, doloribus minus quo totam dolores cupiditate perspiciatis. Atque dicta, ab laborum dolor culpa consectetur nulla voluptatibus.</p>
<img src="../database/modelo_da_tabela.PNG" alt="Imagem do banco de dados" title="Imagem do banco de dados">
<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Iusto quos corporis assumenda saepe ratione voluptatibus eius quam enim, error sunt excepturi vitae architecto accusantium rem in, illum alias repudiandae autem consequuntur pariatur. Placeat est veritatis doloribus ut provident accusantium, necessitatibus rerum molestias at facilis commodi? Mollitia maxime ipsa facere cumque sunt pariatur sint harum odit nisi optio. Illum ut, molestiae cupiditate minus corrupti voluptatibus nihil, rerum placeat fugit nesciunt repudiandae. Cupiditate voluptas mollitia recusandae ipsam adipisci cumque, ducimus vitae, dolor eum quidem expedita, praesentium impedit qui voluptatem! A voluptatibus nostrum consequuntur omnis ea! Maiores veniam alias tempore obcaecati iure placeat.</p>
<h4>Lista de links:</h4>
<ul>
    <li><a href="google.com" target="_blank">Google</a></li>
    <li><a href="youtube.com" target="_blank">YouTube</a></li>
    <li><a href="github.com" target="_blank">GitHub</a></li>
    <li><a href="instagram.com" target="_blank">Instagram</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Itaque adipisci cum esse ad. Et corporis corrupti maxime neque suscipit sequi aliquid eos minus voluptate harum nobis repellendus amet, rerum eius recusandae illum. Explicabo perspiciatis laudantium, distinctio eum blanditiis aut ipsam ipsa, nobis recusandae eius impedit nihil dolor illum quam soluta dolorum vitae accusantium, at ea? Totam ipsum quibusdam odio nihil nesciunt, assumenda quas obcaecati suscipit delectus ab dolor, earum dolores nemo fugiat maxime voluptas sit voluptates perspiciatis sunt quo. Aliquam odit itaque non quas repudiandae asperiores quaerat commodi odio vel.</p>

</body>
</html>',
    '7'
);

INSERT INTO comment (
        com_article,
        com_author_name,
        com_author_email,
        com_comment
) VALUES (
    '1',
    'Setembrino Brino Castelo-Branco',
    'setem@brino.com',
    'Este artigo é muito bom! :D'
), (
    '1',
    'Matheus Arroba',
    'matheusarroba@arroba.com',
    'Este artigo é ruim demais. Você é bobão'
), (
    '1',
    'João Bobo',
    'joao@bobo.com',
    'Este artigo é ruim demais. Você é bobão'
), (
    '2',
    'Thiago Doido',
    'thiago@doido.com',
    'Vou ler esse artigo depois.'
), (
    '3',
    'Joãozinho',
    'joao@zinho.com',
    'officium tuum est populos regere, et soberbos vincere'
);