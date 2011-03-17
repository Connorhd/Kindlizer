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
		<script src="js/kindlizer.js"></script>
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
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
%>
			<h1>Welcome, <%= user.getNickname() %>!</h1>
			<a class="link collection" href="/feeds.jsp">Feed reader (3)</a>
			<a class="link collection" href="/bookmarks.jsp">Bookmarks (not yet available)</a>
			<a class="link collection" href="/articles.jsp">Saved articles (not yet available)</a>
			<a class="link" href="kindlizer.prc">Add Kindlizer to home screen</a>
			<a class="link" href="help.jsp">Kindlizer help</a>
			<a class="link" href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Logout</a>
			<p>Tip: Press <em>Alt+G</em> to refresh the screen and clear any ghosting</p>
<%
    } else {
%>
			<h1>Welcome to Kindlizer</h1>
			<a class="link" href="<%= userService.createLoginURL(request.getRequestURI()) %>">Login</a>
			<a class="link" href="kindlizer.prc">Add Kindlizer to home screen</a>
			<a class="link" href="help.jsp">Kindlizer help</a>
			<p>Tip: Press <em>Alt+G</em> to refresh the screen and clear any ghosting</p>
<%
    }
%>

		</div>
	</body>

</html>
