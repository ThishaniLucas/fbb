// import ballerina/http;
import ballerina/io;
import wso2/facebook4;

public function main() {

    facebook4:FacebookConfiguration facebookConfig = {
        accessToken: "EAApyUyBy81YBAA1B2XaJA7zAVVqqgZBiugejZBhxSNsuUyVQGel8rN7hlKxcRQFFXMQddKJB2sUZB4AoCF3b1t8sPPhINfCeMBUqQZA6dTccqSrQZBZCfXHBYssng6ex53oFX3quKIpoYlzu8Mb2uQ6wKGx8fjH8ZCo1ClIhOOBld3ul2Jv4QtcqTAP1uKkmpi4EDIFHAZBOsAZDZD"
    };

    facebook4:FacebookClient facebookclient = new (facebookConfig);

    //get friend list
    facebook4:FriendList friendList = {};
    var response = facebookclient->getFriendListDetails("me");
    if (response is facebook4:FriendList) {
        friendList = response;
        io:println(friendList.toString());
        
    }
    io:print("working");

    //create post
    facebook4:Post facebookPost = {};
    string pageToken = "";
    string retrievePostId = "";

    var response2 = facebookclient->getPageAccessTokens("me");
    if (response2 is facebook4:AccessTokens) {
        pageToken = response2.data[0].pageAccessToken;
    }

    var response3 = facebookclient->createPost("me","testBalMeassage","","", pageToken);

    //retrieve post
    if (response3 is facebook4:Post) {
        retrievePostId = response3.id;
        io:println("POST ID");
        io:println(retrievePostId);
    }

    var response4 = facebookclient->retrievePost(retrievePostId);

    if (response4 is facebook4:Post) {
        io:println("RESPONSE ID");
        io:println(response4.id);
    }

    //delete post
    var response5 = facebookclient->deletePost(retrievePostId, pageToken);
    if (response5 is boolean) {
        io:println(response5.toString());
    } 
}

