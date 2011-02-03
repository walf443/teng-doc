ページングしたい
=================

searchメソッドを使いつつページングしたい
-----------------------------------------

Teng::Plugin::Pager および、Teng::Plugin::Pager::MySQLFoundRows を使う方法があります。

`Teng::Plugin::Pager <http://search.cpan.org/search?query=Teng%3A%3APlugin%3A%3APager&mode=all>`_ 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

指定したrowsより一件多く取得し、それを元に次のページがあるかどうか、を判断します。

どのRDBMSでも使えて、そこまでパフォーマンスに致命的な影響を与えることがない、というのがメリットですが、ページャーは全体の件数を知ることはできないので、ページングの表示のさせ方は制限されます。

`Teng::Plugin::Pager::MySQLFoundRows <http://search.cpan.org/search?query=Teng%3A%3APlugin%3A%3APager%3A%3AMySQLFoundRows&mode=all>`_ 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

名前の通りMySQLでしか使えません。SQL_CALC_FOUND_ROWSヒントをつけてクエリを実行後、FOUND_ROWS()を呼びだすことで全体の件数を取得します。

場合によっては、クエリのパフォーマンスに大きく影響がでてくる場合があります。

search_by_sqlを書きつつページングしたい
-----------------------------------------

Teng::Plugin::SearchBySQLWithPagerが使えます。


