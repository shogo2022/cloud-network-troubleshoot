#EC2 Public IP 
output server_public_ip_address {
  value = aws_instance.handsonlab_web[0].public_ip
}

#Scenario goals
output goal {
  value = "Open your web browser and navigate to the server public ip. In this quiz, you should be greeted with message straight away!\n"
}

output goal_jp {
  value = "WEBブラウザでサーバのパブリックIPを開けてください。問題がなければメッセージが表示されるはずです！\n"
}