<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Text" %>
<%@ page import="uk.co.connorhd.kindlizer.PMF" %>
<%@ page import="uk.co.connorhd.kindlizer.KindlizerUser" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="icon" type="image/png" href="images/icon16.png">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>Kindlizer</title>
		<link rel="stylesheet" href="css/kindle.css" type="text/css" />
		<script type="text/javascript" src="https://www.google.com/jsapi?autoload=%7B%22modules%22%3A%5B%7B%22name%22%3A%22feeds%22%2C%22version%22%3A%221%22%7D%5D%7D&key=ABQIAAAAd7mJjdsAYy3gAu9Pb2MahhQ4avvOi7ZEKnc5s2WlgBAK_j1JehSYZhLtCAkLZJmvUA3Nn53xTF0wXg"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
		<script src="js/jquery.waitforimages.js"></script>
		<script src="js/jquery.history.js"></script>
		<script src="js/kindlizer.js"></script>
		<script>
			var savedFeeds = [
				"http://feeds.guardian.co.uk/theguardian/rss",
				"http://www.engadget.com/rss.xml",
				"http://news.google.com/news?output=rss"
			];
			$(function () {
				var showFeed = function (feedURL) {
					clearScreen();
					$('#kindlize').append('<p>Loading feed...</p>');
					kindlize($('#kindlize'));

					var feed = new google.feeds.Feed(feedURL);
					feed.load(function (feed) {
						$('#kindlize').append('<p>Feed loaded.</p>');
						$('#kindlize').append('<p>Kindlizing feed...</p>');
						kindlize($('#kindlize'));
						feed = feed.feed;
						$('#kindlize').append('<h1>'+feed.title+'</h1>');
						$('#kindlize').append('<h2>'+feed.description+'</h2>');
						var i;
						for (i = 0; i < feed.entries.length; i++) {
							$('#kindlize').append('<h3 class="title"><a href="'+feed.entries[i].link+'">'+feed.entries[i].title+'</a></h3>');				
							$('#kindlize').append('<h4>'+feed.entries[i].author+' - '+feed.entries[i].publishedDate+'</h4>');
							// TODO: Better tidying of feeds
							$('#kindlize').append(('<p>'+feed.entries[i].content.replace(/<br( \/)?>\W*<br( \/)?>/g,'</p><p>').replace(/<div/g,'<span').replace(/<\/div/g,'</span')+'</p>').replace(/(\s*<(\/)?p>\s*)+/g,'<p>'));
						}
						$('#kindlize').waitForImages(function () {
							clearScreen();
							kindlize($('#kindlize'));
						});
					});
				};
				
				var loadTitles = function (feeds) {
					clearScreen();
					
					$('#kindlize').append('<a href="" onclick="loadTitle(prompt(\'\')); return false" class="link">Add feed URL</a>');
					kindlize($('#kindlize'));
					
					var i;
					for (i = 0; i < feeds.length; i++) {
						loadTitle(feeds[i]);
					}				
				};
				
				loadTitle = function (feedUrl) {
					if (feedUrl.indexOf(':') === -1) {
						feedUrl = 'http://'+feedUrl;
					}

					feed = new google.feeds.Feed(feedUrl);
									
					feed.load(function (feed) {
						if (feed.feed.title !== undefined) {
							if (savedFeeds.indexOf(feedUrl) === -1) {
								savedFeeds.push(feedUrl);
							}
							feed = feed.feed
							$('#kindlize').append('<a onclick="$.history.load(\''+feed.feedUrl+'\'); return false" href="" class="link collection">'+((feed.title.length > 20) ? feed.title.substring(0,20)+'...' : feed.title)+'<span style="float:right; font-weight: normal; font-size: 0.8em; font-style: normal; font-family: serif; padding: 4px 40px 0 0;">'+(new Date(feed.entries[0].publishedDate)).toDateString()+'</span></a>');
							kindlize($('#kindlize'));
						} else {
							alert('Error with feed: '+feedUrl);
						}
					});
				}
				$.history.init(function(hash){
        			if(hash == "") {
            			loadTitles(savedFeeds);
        			} else {
            			showFeed(hash);
       				}
   				});
			});
		</script>
	</head>
	<body>
		<div id="outer">
			<div id="scroll">
				<div id="screen">
					<div id="footer"></div>
				</div>
			</div>
		</div>
		<div id="kindlize" style="display: none;">
		</div>
	</body>
</html>
