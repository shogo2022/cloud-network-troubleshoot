#WEB Public IP 
output web_public_ip_address {
  value = aws_instance.handsonlab_web[0].public_ip
}

#CSR Public IP
output csr_public_ip_address {
  value = aws_eip.handsonlab_frontend_csr_eip.public_ip
}

#Scenario goals
output goal {
  value = "Open your web browser and navigate to the server public ip. Once the webpage is loaded, click the button. It should show some images, but it appears not working. Login to your aws web management console and find what causes this problem, and change the configuration accordingly. Once you fixed the issue, you should be presented with images every time yoou press the button!\nYou can also access CSR console via ssh (use 'admin' and 'supersecretpass' to login)"
}

output goal_jp {
  value = "WEBブラウザでサーバのパブリックIPを開けてください。ボタンを押しても何も起こりませんね。AWS管理コンソールにログインして、問題を調査、修復してください。問題が解決していれば、ボタンを押すごとに画像が表示されるはずです！\nCisco CSRにSSHでアクセスする時は、ユーザー名admin、パスワードsupersecretpass、でログインしてください。"
}