はじめに
----------

実行例について
----------------
Tengのインスタンスを例を簡潔にするため、Tengのインスタンスを作るところまでを次のようにまとめています。 ::

    my $teng = do('setup_teng_instance.pl')
        or die $@;

ケースにもよりますが、setup_teng_instance.pl内では以下のようになっています。

.. literalinclude:: ./setup_teng_instance.pl
    :language: perl


