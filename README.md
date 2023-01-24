# ELK-JARVIS For Cisco IOS

Monitoring of network devices on customers is carried out using a network monitoring system based on the ELK stack. Development of an ELK stack based monitoring system using the SNMP protocol along with device logs to get the updated status of network devices. The ELK stack based Dashboard monitoring system displays the Hostname, CPU Utilation, Memory Utilization and Input/Output interface of the monitored device. This device Severity information from level 1 to 5 is via telegram bot notification. The implementation and testing of black-box testing of the ELK stack monitoring system can monitor network devices by collecting SNMP data and logs from monitored network devices and displaying visualizations in the Dashboard based on kibana and sending notifications using the Telegram bot.

# conf.d 
* configuration for logstash 

# ruby-script
* script ruby 

# 01_input_cisco.conf
* configure your IP addres device
* configure your community SNMP

# 01_output_cisco.conf
* configure your host elasticsearch
* configure your ussername elasticsearch
* configure your password elasticsearch

# 02_output_cisco.conf
* configure your host elasticsearch
* configure your ussername elasticsearch
* configure your password elasticsearch
* configure your bot token telegram
* configure your chat id where the telegram bot will do the reporting

# Main Dashboard
<p align="center">
<img src="https://github.com/muhrifqi17/ELK-JARVIS/blob/8779b061938ba40d7c01157c7c882dd08e9ba4d8/Documentation/Screenshot%20Main%20Dashboard%20-%20Elastic.png"/>
</p>

# Detail Dashboard
<p align="center">
<img src="https://github.com/muhrifqi17/ELK-JARVIS/blob/8779b061938ba40d7c01157c7c882dd08e9ba4d8/Documentation/Screenshot%20Dashboard%20for%20KIMNTT-RT-01%20-%20Elastic.png"/>
</p>

# Telegram Report
<p align="center">
<img src="https://github.com/muhrifqi17/ELK-JARVIS/blob/8779b061938ba40d7c01157c7c882dd08e9ba4d8/Documentation/Screenshot%20BOT%20Telegram.PNG"/>
</p>
