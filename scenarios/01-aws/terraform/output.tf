#EC2 Public IP 
output server_public_ip_address {
  value = aws_instance.handsonlab_web[0].public_ip
}

#Scenario goals
output goal {
  value = "Open your web browser and navigate to the server public ip. The connection should be timed out. Login to your aws web management console and find what causes this problem, and change the configuration accordingly. Once you fixed the issue, you should be greeted with the message on your web browser!\n"
}

output goal_jp {
  value = "WEBブラウザでサーバのパブリックIPを開けてください。タイムアウトになりましたか？AWS管理コンソールにログインして、問題を調査、修復してください。WEBブラウザでメッセージが表示されたら成功です！\n"
}