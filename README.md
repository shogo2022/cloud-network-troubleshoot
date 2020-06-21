# cloud-network-troubleshoot

_Created by network engineer for network engineer who finds cloud network different from enterprise network_
-クラウド環境のネットワークが苦手なネットワークエンジニアがクラウドが得意になる問題集-

# クイックリファレンス

This repository is a collection of trouble scenarios which every network engineer faces during their early time of cloud adoption. You will procure a few resources in (sometimes multiple) cloud environment to emulate each scenario.
You will be given a guide once you setup the resources, most of the time (if not all) there is a problem in the configuration of the network, and your goal is to change the configuration and make it work.

このレポジトリにはネットワークエンジニアがクラウドを触り始めた時に陥りがちなトラブルの数々がシナリオとして保存されています。
このシナリオを使うと、実際のクラウド上にリソースを配置してそれらのトラブルの調査と解決をハンズオンで学ぶことができます。
いずれのシナリオも最初にガイドが与えられますので、その情報を起点としてネットワークの問題を解決してみてください。

- **Where to file issues**:
[https://github.com/shogo2022/cloud-network-troubleshoot/issues](https://github.com/shogo2022/cloud-network-troubleshoot/issues)

# Note

> **Warning #1:** Each scenario will procure a few resources on your own cloud environment. Please do not deploy these scenarios in your production environment.

> **Warning #2:** Each scenario will be provided with terraform files. You can delete those resources procured during the setup with the command `terraform destroy`, however those resourcces you add by yourself along the course will *NOT* be deleted. Please *DO* remove those resources you added by yourself prior to `terraform destroy`. It is always recommended and you should check if there is any resources left behind on web management console of aws.

## System requirement

* Python3.6以上が必要です。
* Terraform 0.12 [インストールされ、$PATHにある](https://learn.hashicorp.com/terraform/getting-started/install.html)必要があります。
* The AWS CLI[がインストールされ、$PATHにある](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)ことと、リソースの作成と削除権限を持ったAWSアカウントが必要です。

## クイックスタート

```
$ git clone git@github.com:shogo2022/cloud-network-troubleshoot.git ./cloud-network-troubleshoot
$ cd cloud-network-troubleshoot
$ ls -l scenarios
$ cd scenarios/00-tutorial