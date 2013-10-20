## 使い方

authorized_keys を自分の公開鍵に置き換える。

    $ cp ~/.ssh/authorized_keys ./authorized_keys
    $ docker build . -t marcie001/chefbase
    $ docker run -d marcie001/chefbase

`knife solo bootstrap foo` とかで Chef solo を実行する。
