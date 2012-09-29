動的に条件の変動するクエリを書きたい
====================================

SQL::Makerを使います。

.. literalinclude:: ./dynamic_query.pl
    :language: perl


dynamic_query.plというファイル名で保存し、次のように実行してみましょう。 ::

    $ perl ./dynamic_query.pl
    # SQL: "SELECT * FROM "user""
    # BIND: 

    $ perl ./dynamic_query.pl name walf443
    # SQL: "SELECT * FROM "user" WHERE ("name" = ?)"
    # BIND: walf443

    $ perl ./dynamic_query.pl age 26
    # SQL: "SELECT * FROM "user" WHERE ("age" = ?)"
    # BIND: 26

    $ perl ./dynamic_query.pl name walf443 age 26
    # SQL: "SELECT * FROM "user" WHERE ("name" = ?) AND ("age" = ?)"
    # BIND: walf443, 26

