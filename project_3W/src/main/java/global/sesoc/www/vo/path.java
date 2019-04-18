package global.sesoc.www.vo;

import java.util.ArrayList;


public 	class path{
	int pathType;
	ArrayList<subPath> subPath;
	Info info;
	
	public path() {
		super();
	}

	public path(int pathType, ArrayList<global.sesoc.www.vo.subPath> subPath, Info info) {
		super();
		this.pathType = pathType;
		this.subPath = subPath;
		this.info = info;
	}

	public int getPathType() {
		return pathType;
	}

	public void setPathType(int pathType) {
		this.pathType = pathType;
	}

	public ArrayList<subPath> getSubPath() {
		return subPath;
	}

	public void setSubPath(ArrayList<subPath> subPath) {
		this.subPath = subPath;
	}

	public Info getInfo() {
		return info;
	}

	public void setInfo(Info info) {
		this.info = info;
	}

	@Override
	public String toString() {
		return "path [pathType=" + pathType + ", subPath=" + subPath + ", info=" + info + "]";
	}
}
