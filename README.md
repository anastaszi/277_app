##  Fashion News App

[VideoDemo](https://youtu.be/mYnr6Ue9SgY)

The app uses custom REST API endpoints to display records from DB (stored in AWS DynamoDB).
Each record is a news-type record with :
* title
* author
* category
* text
* url link for the image associated with this record (stored in AWS S3 and configured to be accessed through AWS CloudFront)

### Features
* user can check the list of latest news
* user can check details for each news
* user can search news by category
* user can press Update Button to download the latest news if there were any updated in the DB

![](./img/main_screen.png)

![](./img/details_view.png)

![](./img/category.png)

![](./img/selected_category.png)


Web that allows adding news to the DB [link](https://master.d2b6g6xmfhelha.amplifyapp.com/)
GitHub for web [link](https://github.com/anastaszi/277_web)
