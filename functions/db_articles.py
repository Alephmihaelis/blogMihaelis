from flask_mysqldb import MySQL, MySQLdb

def get_all(mysql): # Obtém todos os artigos
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
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql)
    articles = cur.fetchall()
    cur.close()

    return articles

def get_one(mysql, artid): # Obtém um artigo pelo ID
    sql = '''
    SELECT
    -- Campos do artigo
    art_id, art_date, art_title, art_content,
    -- Campos do autor
        sta_id, sta_name, sta_image, sta_description, sta_type,
    -- Obtém a data em PT-BR pelo pseudo-campo 'art_datebr'
        DATE_FORMAT(art_date, '%%d/%%m/%%Y às %%H:%%i') AS art_datebr,
        
        -- Calcula a idade para 'sta_age' considerando ano, mês e dia do nascimento
        TIMESTAMPDIFF(YEAR, sta_birth, CURDATE()) -
            (DATE_FORMAT(CURDATE(), '%%m%%d') < DATE_FORMAT(sta_birth, '%%m%%d')) AS sta_age
    FROM article
    INNER JOIN staff ON art_author = sta_id
    WHERE art_id = %s
        AND art_status = 'on'
        AND art_date <= NOW();
        '''
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql, (artid,))
    article = cur.fetchone()
    cur.close()

    return article

# Atualiza as visualizações do artigo
def update_views(mysql, artid):
    sql = 'UPDATE article SET art_view = art_view + 1 WHERE art_id = %s'
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql, (artid,))
    mysql.connection.commit()
    cur.close()

    return True

def get_more(mysql, sta_id, art_id, limit): # Obtém artigos do autor
    sql = '''
    -- Obter até 4 artigos aleatórios do autor (id, title, thumbnail) --
    -- Exceto o artigo atual --
    -- Obtém id, title, thumbnail 
    SELECT art_id, art_title, art_thumbnail
    -- da tabela 'article'
    FROM article
    -- Do autor
    WHERE art_author = %s
    -- cujo status é 'on
	AND art_status = 'on'
    -- cuja data de publicação está no passado
	AND art_date <= NOW()
    -- não obtém o artigo atual
	AND art_id != %s
    -- em ordem aleatória
    ORDER BY RAND()
    -- até 4 artigos
    LIMIT %s;
'''
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql, (sta_id, art_id, limit,))
    articles = cur.fetchall()
    cur.close()

    return articles