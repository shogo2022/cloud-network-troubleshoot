# Scenario: Connection to DB server lost! No. 1 - DBサーバへの接続が切れた。その1

## Walkthrough

Deployed sources and access flow:
![access flow](./asset/05-guide01.jpg)

1. First, let's check what is deployed.
![tag manager](./asset/05-guide02.jpg)
Seeing this, you can see what instances are deployed what resources are deployed for this scenario.

2. It depends on you where to start, but in this scenario we take a look at Security group for DB. Click the Security group identifier in the tag editor will open another tab to show you the resource.
![security group](./asset/05-guide03.jpg)
I'm using mariadb on port tcp/3306, but it appears there is no rule allowing this communicatioin.  
Let's allow connection to DB from whole VPC subnet(172.16.0.0/16)
![answer](./asset/05-guide04.jpg)

4. Now press the button on the web site, and you should get an image.

