クイックスタート
================

はじめに
--------

この章は、Tengを使ったことない人が試しに使ってみるガイドを目指しています。

なるべくわかりやすく、そのまま実行可能なように記述してあるつもりですが、多少初心者には不親切かもしれません。

この章では、ある程度、他のORMやDBIの知識のある人が試しにTengを使い始めることを目的としているので、よくあるメソッド等でもあえて紹介する順序を後にしていることがあります。

環境の準備
----------
まず、perlを導入しましょう。perl5.8以降であれば、基本的には動作するはずです。

Tengを以下のコマンドでインストールします。 ::

    $ cpanm Teng

この文書では、導入と扱いの手軽さからSQLiteをRDBMSとして用いるので、用意してください。
SQLiteのバージョンは、3.0以降です。

perlからSQLiteを扱うためにDBD::SQLiteを導入します。 ::

    $ cpanm DBD::SQLite

DBの作成
---------

まず、SQLiteのデータベースを作ります。コマンドラインで以下のように入力してください。 ::

    $ sqlite3 quickstart.sqlite
    sqlite> .exit

テーブルの作成
--------------

ここでは、ユーザーを管理するプログラムについて考えます。

nameというカラムとageというカラムを持つuserテーブルを作りましょう。

以下のようなプログラムを作ります。

.. literalinclude:: ./quickstart/create-table.pl

Teng::Schema::Loaderは、dbhから現在のテーブル情報を動的に取得して、Teng用のSchemaを構築してくれるモジュールです。

Teng#doはDBI#doを実行し、エラーが起きた際には、エラーをフォーマットしつつdieしてくれます。SQLの結果を取得せずに任意のSQLを実行したい場合に便利です。

create-table.plという名前で保存し、実行してみましょう。 ::

    $ perl create-table.pl

テーブルが実際にできたか確認してみましょう。 ::

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

試しにもう一度実行してみましょう。 ::

    $ perl 001-create-table.pl
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@ Teng 's Exception @@@@@
    Reason  : DBD::SQLite::db do failed: table user already exists at /Users/yoshimi/perl5/perlbrew/perls/perl-5.12.1/lib/site_perl/5.12.1/Teng.pm line 297.

    SQL     :
                  CREATE TABLE user (
                      id INT UNSIGNED NOT NULL,
                      name VARCHAR NOT NULL,
                      age INT UNSIGNED NOT NULL
                  )
    
    BIND    : $VAR1 = '';
    
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     at 001-create-table.pl line 23

これは、既にquickstart.sqliteにuserテーブルが存在しているのに作ろうとしたため、です。

データの挿入
------------

適当なデータを挿入してみましょう。

.. literalinclude:: ./quickstart/insert-user.pl

ところで、このコードはTengクラスのインスタンスを作るところまでは、前回のコードと同様で冗長ですね。ここまでのコードはこれからも何度か出てきますし、説明上も見辛いので、インスタンスを作る部分までの部分は別ファイルへ外出ししてしまいましょう。

.. literalinclude:: ./quickstart/create-teng-instance.pl

これを、create-teng-instance.plとして保存し、先ほどのコードを下記のように変更します。

.. literalinclude:: ./quickstart/insert-user-fix.pl

Tengのインスタンスを作るところまでは、今後はこのように記述します。

Teng#insert($table, $hashref)は$hashrefの内容を$tableテーブルへ1レコードして追加してくれます。戻り値はTeng::Rowクラスを継承したクラスのインスタンスです。(これを今後はRowオブジェクトと呼びます)

戻り値でRowオブジェクトを返していますが、戻り値でRowオブジェクトを必要としない場合には、Teng#fast_insertが使えます。

実際にデータが挿入されたのか確認してみましょう。 ::

    $ sqlite3
    sqlite> SELECT * FROM user;
    1|walf443|26
    2|walf444|30

ちゃんとデータが入っていますね。

クエリの確認
------------

Tengでメソッドを実行した際に、どのようなSQLが実行されたのか知りたい、ということはあると思います。

そういうときは色々手段はありますが、現時点ではDBIx::QueryLogを使うのがお手軽かと思います。 ::

    perl -MDBIx::QueryLog ./insert-user-fix.pl

実行してみると、思ったよりたくさんのクエリが実行されているのにびっくりされたかもしれません。

これは、ほとんどはTeng::Schema::Loaderにより実行されているクエリです。

Schemaを明示的に定義してやることでこれらのクエリは走らないようにすることもできます。

その方法に関しては後述します。

データの検索
------------

せっかくなので先程の確認の操作をTengからもやってみましょう。

.. literalinclude:: ./quickstart/search_named-user.pl

Teng#search_named($sql, $hashref, $table_name)は、$sqlをSQLとして実行し、Teng::Iteratorオブジェクトを返します。

SQL内で、:keywordのように記述してあり、$hashrefのキーとして"keyword"が存在していた場合には、:keywordをプレイスホルダに置きかえ、$hashref->{keyword}の値をbindします。
$hashrefの値がArrayRefの場合には、(?,?,?)のように置きかえてくれるため、INの記述が楽です。

$table_nameはTeng::IteratorがRowオブジェクトを生成する際のクラス名を決定するために必要です。

$iterは、Teng::Iteratorオブジェクトです。Teng::Iterator#nextを呼び出すたびに、Rowオブジェクトを生成してくれます。

また、簡単な条件での検索であればTeng#searchメソッドを使うと生でSQLを記述しなくてもよいです。

.. literalinclude:: ./quickstart/search-user.pl

データの削除
------------

データを削除する際にはTeng#delete、あるいは、Teng::Row#deleteが使えます。

.. literalinclude:: ./quickstart/delete-user.pl

戻り値は、削除された件数です。Teng#deleteは複数件を一気に消すときに便利でしょう。

.. literalinclude:: ./quickstart/delete-user-row.pl

Rowオブジェクトのdeleteに何かしらのhookを入れているとき(キャッシュの削除等)に使います。
各レコードの削除ごとに1回SQL発行されるので、ケースによってはやや注意して使う必要があるかもしれません。

データの変更
------------

データのupdateもdeleteとほぼ同じです。

.. literalinclude:: ./quickstart/update-user-row.pl

Rowオブジェクトからupdateした場合、条件が単純であれば元のRowオブジェクトのデータもupdateされていますが、DBに保存されている値と一致していることは保証されないので、取得しなおすのが無難です。

条件にはHashRefだけでなく、ScalarRefを指定することもでき、これらは式や条件を指定する際に便利です。

