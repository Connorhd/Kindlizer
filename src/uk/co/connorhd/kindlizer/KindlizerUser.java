package uk.co.connorhd.kindlizer;

import java.util.Vector;

import javax.jdo.annotations.Extension;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;
import com.google.appengine.api.users.User;

@PersistenceCapable
public class KindlizerUser {
	@SuppressWarnings("unused")
	@PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    @Extension(vendorName="datanucleus", key="gae.encoded-pk", value="true")
    private String encodedKey;
	
	@Persistent
    private Vector<Text> feed;
	private Vector<Text> bookmark;
    
    public KindlizerUser(User user) {
    	this.encodedKey = KeyFactory.keyToString(KeyFactory.createKey(KindlizerUser.class.getSimpleName(), user.getUserId()));
    	this.feed = new Vector<Text>();
    	this.bookmark = new Vector<Text>();
    }
    
    public Vector<Text> getFeeds() {
    	return this.feed;
    }
    
    public void addFeed(String str) {
    	this.feed.add(0, new Text(str));
    }
    
    public void removeFeed(int index) {
    	this.feed.remove(index);
    }
    
    public Vector<Text> getBookmarks() {
    	return this.bookmark;
    }
    
    public void addBookmark(String str) {
    	this.bookmark.add(0, new Text(str));
    }
    
    public void removeBookmark(int index) {
    	this.bookmark.remove(index);
    }
}
