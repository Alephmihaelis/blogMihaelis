from flask_mysqldb import MySQL, MySQLdb

def get_all(mysql, limit=0): # Obtém todos os artigos
    if limit == 0:
        subsql = ''
    else:
        subsql = f'LIMIT {limit}'
    sql = f'''
    SELECT art_id, art_title, art_resume, art_thumbnail
    FROM article
    WHERE art_status = 'on'
        AND art_date <= NOW()
    ORDER BY art_date DESC
    { subsql };
    '''
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql)
    articles = cur.fetchall()
    cur.close()

    return articles

def get_one(mysql, artid): # Obtém um artigo pelo ID
    sql = '''
    SELECT
    art_id, art_date, art_title, art_content,
        sta_id, sta_name, sta_image, sta_description, sta_type,
        DATE_FORMAT(art_date, '%%d/%%m/%%Y às %%H:%%i') AS art_datebr,
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
    SELECT art_id, art_title, art_thumbnail
    FROM article
    WHERE art_author = %s
	AND art_status = 'on'
	AND art_date <= NOW()
	AND art_id != %s
    ORDER BY RAND()
    LIMIT %s;
'''
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql, (sta_id, art_id, limit,))
    articles = cur.fetchall()
    cur.close()

    return articles

def articles_search(mysql, query, limit=0):
    
    if limit == 0:
        subsql = ''
    else:
        subsql = f'LIMIT {limit}'

    sql = f'''
        SELECT `art_id`, `art_title`, `art_resume`, `art_thumbnail`
        FROM article
        WHERE (
                art_title LIKE %s
                OR art_resume LIKE %s
                OR art_content LIKE %s
            )
            AND art_status = 'on'
            AND art_date <= NOW()
        ORDER BY art_date DESC
        {subsql};
        '''
    like_term = f'%{query}%'
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql, (like_term, like_term, like_term,))
    articles = cur.fetchall()
    cur.close()

    return articles

def most_commented(mysql, limit=4):
    sql = '''
        SELECT
            a.art_id, 
            a.art_title,
            a.art_thumbnail,
            COUNT(c.com_id) AS comment_count
        FROM
            article a
        LEFT JOIN
            comment c ON a.art_id = c.com_article AND c.com_status = 'on'
        WHERE
            a.art_status = 'on' 
            AND a.art_date <= NOW()
        GROUP BY
            a.art_id, a.art_title
        HAVING
            comment_count > 0
        ORDER BY
            comment_count DESC
        LIMIT %s;
'''
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql, (limit,))
    articles = cur.fetchall()
    cur.close()

    return articles

def most_viewed(mysql, limit=4):

    sql = '''
        SELECT
            a.art_id, 
            a.art_title,
            a.art_thumbnail,
            a.art_view
            FROM
            article a
        WHERE
            a.art_status = 'on' 
            AND a.art_date <= NOW()
        GROUP BY
            a.art_view
        ORDER BY
            art_view DESC
        LIMIT 4;
        '''
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(sql,)
    articles = cur.fetchall()
    cur.close()

    return articles