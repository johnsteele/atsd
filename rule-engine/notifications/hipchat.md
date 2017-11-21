# Hipchat

https://www.atlassian.com/software/hipchat/enterprise/data-center

## Prerequisites

* Install [Hipchat Data Center](hipchat_data_center_install.md)
* Install [WebDriver](README.md#install-web-driver)

> To make requests over HTTPS you need to generate ssl self-signed certificate and copy it to ATSD server truststore

## Create a bot

* Log in to HipChat as admin
* Click **System**

    ![](images/system.png)

* Go to **Team Info**
* Navigate to invite URL, click **Enable**

    ![](images/invite_url.png)

* Copy the link
* Sign out (right upper corner)

    ![](images/sign_out.png)

* Paste link to browser, press **Enter**
* Fill in the fields, click **Sign Up**

    ![](images/atsd_bot.png)
    
## Generate token

* Click on bot icon (right upper corner)

    ![](images/bot_icon.png)
    
* Click **Profile**
* Go to **API tokens**

> Make sure you are using API v2: there should be no warnings

* Select **Send Message** from **Scopes** field
* Fill in the **Label** filed
* Click **Create**

    ![](images/token.png)

* Copy the token
* Log out

## Create a room

* Log in to HipChat as admin
* Click **Start chatting**
* Click **Create a room**
    
    ![](images/create_room.png)
    
* Fill in the fields, check (enable) **Private room**, click **Create room**

    ![](images/private_room.png)
    
* Enter members to receive notifications from ATSD (you can do it later), enter bot user, click **Invite people**

    ![](images/invite_bot.png)

* Get room id:
    * click on team name
    
    ![](images/team_name.png)
    
    * click on recently created room
    
    ![](images/created_room.png)
    
    * look at URL, last number is the room id
    
    ![](images/room_url.png) 
    


