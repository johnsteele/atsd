# Hipchat Data Center Installation

* Download OVA 3.1.1 https://s3.amazonaws.com/hipchat-server-stable/dc/HipChat.ova
* Run VM

    ![](images/hipchat_vm.png)
    
  To manage instance use following credentials:
                     
  ```bash
  Login: admin
  Password: hipchat
  ```
    
* Navigate to https://HIPCHAT_HOST

    ![](images/set_up_hipchat.png)

* Fill in the fields, click **Continue**

    ![](images/set_up_postgres.png)

* Fill in the fields, click **Continue**

    ![](images/setup_redis_and_nfs.png)

* Click **Request an evaluation license.**

    ![](images/request_license.png)
    
* Click **Generate License** and cope the key to the **License Key** field
* Fill in the other fields and click **Finish**

    ![](images/team_information.png)
    
    If setup is successful you will see following:

    ![](images/stup_success.png)
    
See more info:

* [Deploy HipChat Data Center](https://confluence.atlassian.com/hipchatdc3/deploy-hipchat-data-center-907350423.html)

* [Hardware requirements for a small-scale HipChat Data Center deployment](https://confluence.atlassian.com/hipchatdc3/set-up-a-small-scale-hipchat-data-center-cluster-939689319.html#Setupasmall-scaleHipchatDataCentercluster-Hardwarerequirementsforasmall-scaleHipChatDataCenterdeployment)

