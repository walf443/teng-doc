クイックスタート
================

はじめに
--------

この文書は、Tengを使ったことない人が試しに使ってみるガイドを目指しています。

環境の準備
----------
まず、perlを導入しましょう。perl5.8以降であれば、基本的には動作するはずです。

Tengを以下のコマンドでインストールします。::

    $ cpanm Teng

この文書では、導入と扱いの手軽さからSQLiteをRDBMSとして用いるので、用意してください。
SQLiteのバージョンは、3.0以降です。

perlからSQLiteを扱うためにDBD::SQLiteを導入します。::

    $ cpanm DBD::SQLite

DBの作成
---------

まず、SQLiteのデータベースを作ります。コマンドラインで以下のように入力してください。::

    $ sqlite3 quickstart.sqlite
    sqlite> .exit

テーブルの作成
--------------

ここでは、ユーザーを管理するプログラムについて考えます。

nameというカラムとageというカラムを持つuserテーブルを作りましょう。

以下のようなプログラムを作ります。

  .. include:: ./001-create-table.pl

Teng::Schema::Loaderは、dbhから現在のテーブル情報を動的に取得して、Teng用のSchemaを構築してくれるモジュールです。

Teng#doはDBI#doを実行し、エラーが起きた際には、エラーをフォーマットしつつdieしてくれます。

001-create-table.plという名前で保存し、実行してみましょう。::

    $ perl 001-create-table.pl

テーブルが実際にできたか確認してみましょう。::

    $ sqlite3 quickstart.sqlite
    sqlite> .schema
    CREATE TABLE user (
            id INT UNSIGNED NOT NULL,
            name VARCHAR NOT NULL,
            age INT UNSIGNED NOT NULL
        );
    sqlite> 
    sqlite> .exit

userテーブルができていますね。

試しにもう一度実行してみましょう。::

    .. $ perl 001-create-table.pl
    .. @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    .. @@@@@ Teng 's Exception @@@@@
    .. Reason  : DBD::SQLite::db do failed: table user already exists at /Users/yoshimi/perl5/perlbrew/perls/perl-5.12.1/lib/site_perl/5.12.1/Teng.pm line 297.

    .. SQL     :
    ..               CREATE TABLE user (
    ..                   id INT UNSIGNED NOT NULL,
    ..                   name VARCHAR NOT NULL,
    ..                   age INT UNSIGNED NOT NULL
    ..               )
    ..
    .. BIND    : $VAR1 = '';
    ..
    .. @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    ..  at source/001-create-table.pl line 23

これは、既にquickstart.sqliteにuserテーブルが存在しているのに作ろうとしたため、です。

データの挿入
------------

適当なデータを挿入してみましょう。

  .. include:: ./002-insert-user.pl

ところで、このコードはTengクラスのインスタンスを作るところまでは、前回のコードと同様で冗長ですね。ここまでのコードはこれからも何度か出てきますし、説明上も見辛いので、インスタンスを作る部分までの部分は別ファイルへ外出ししてしまいましょう。

  .. include:: ./create-teng-instance.pl

これを、source/以下にcreate-teng-instance.plとして保存し、先ほどのコードを下記のように変更します。

  .. include:: ./003-insert-user-fix.pl

Tengのインスタンスを作るところまでは、今後はこのように記述します。

Teng#insert($table, $hashref)は$hashrefの内容を$tableテーブルへ1レコードして追加してくれます。戻り値はTeng::Rowクラスを継承したクラスのインスタンスです。

戻り値を取得するために、SELECT文を一回発行しますが、発行してほしくない際にはTeng#fast_insertが使えます。

データの検索
------------
実際にデータが挿入されたのか確認してみましょう。


データの削除
------------

データの変更
------------

