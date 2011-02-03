動的に条件の変動するクエリを書きたい
====================================

SQL::Makerを使います。

.. literalinclude:: ./dynamic_query.pl
    :language: perl


dynamic_query.plというファイル名で保存し、次のように実行してみましょう。 ::

    $ perl ./dynamic_query.pl
    $ perl ./dynamic_query.pl name walf443
    $ perl ./dynamic_query.pl age 26
    $ perl ./dynamic_query.pl name walf443 age 26


