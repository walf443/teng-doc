データをflagged utf8で扱いたい
==============================

基本的にはDB側のデータはUTF8で保存しておくのが無難です。

MySQLの場合
----------------

mysql_enable_utf8オプションを使いましょう

SEE ALSO: http://search.cpan.org/search?query=DBD%3A%3Amysql&mode=module

SQLiteの場合
-----------------

sqlite_unicodeアトリビュートを有効にしましょう。

SEE ALSO: http://search.cpan.org/search?query=DBD%3A%3ASQLite&mode=module

