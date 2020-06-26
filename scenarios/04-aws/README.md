# Scenario: Web server is not working! No. 4 - ウェブサーバが動かない。その4

**Difficulty:** Easy - 簡単

**Scenario goal:**

Browse the message on the web server from the internet.  
ウェブサーバのメッセージをインターネットから見る。

**Command:**
```
$ cd scenarios/03-aws/asset
$ terraform init
$ terraform apply
(once completed)
$ terraform destroy
```

**Resources to be deployed:**

* 1 VPC with:
  * EC2 x 1

## Summary

You are building a simple web server. As you are a Linux expert, you deployed your Linux server without any problem. However you cannot browse the web site you created from the internet. Your goal is to change a configuration in AWS and maake it work.

あなたはWEBサーバを構築しています。LinuxマスターであるあなたはWEBサーバをものの5分で構築してしまいました。しかし、WEBサイトはなぜか表示されません。AWSの設定をどうにか変更してWEBサイトを表示させましょう。

## Guide chart

![guide chart](./asset/02-route.jpg)

## Guide

1. Apply terraform file and deploy resources on AWS by issueing `$ terraform apply`.

2. Check if web site is reachable. And confirm it is NOT reachable.

3. Login to your aws management console, and check what is not configured correctly.

4. Once you modified the parameters on AWS, check web browser if it works ok.

5. `$ terraform destroy`

6. Login to your aws again and confirm no resources are left not to be deleted.

この方法のチートシートは[こちら](./cheat_sheet.md).

## Comment
🎉
Conguratulations! 
おめでとうございます！

