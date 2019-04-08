package global.sesoc.www.vo;

public class NewsVO {
	String title;
	String originallink;
	String link;
	String description;
	String pubDate;
	
	
	public NewsVO() {
		super();
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getOriginallink() {
		return originallink;
	}


	public void setOriginallink(String originallink) {
		this.originallink = originallink;
	}


	public String getLink() {
		return link;
	}


	public void setLink(String link) {
		this.link = link;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getPubDate() {
		return pubDate;
	}


	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}


	public NewsVO(String title, String originallink, String link, String description, String pubDate) {
		super();
		this.title = title;
		this.originallink = originallink;
		this.link = link;
		this.description = description;
		this.pubDate = pubDate;
	}
}
