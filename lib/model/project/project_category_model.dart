
//  项目的二级分类model(项目本身是一个一级分类)
//  每个二级分类model对应显示在项目页面顶部的tab中
class ProjectCategoryModel{
	int courseId;
	int id;  //项目分类id，获取分类下的项目时要用到
	String name;  //分类名称
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;

	ProjectCategoryModel({this.courseId, this.id, this.name, this.order, this.parentChapterId, this.userControlSetTop, this.visible});

	ProjectCategoryModel.fromJson(Map<String, dynamic> json) {
		courseId = json['courseId'];
		id = json['id'];
		name = json['name'];
		order = json['order'];
		parentChapterId = json['parentChapterId'];
		userControlSetTop = json['userControlSetTop'];
		visible = json['visible'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['courseId'] = this.courseId;
		data['id'] = this.id;
		data['name'] = this.name;
		data['order'] = this.order;
		data['parentChapterId'] = this.parentChapterId;
		data['userControlSetTop'] = this.userControlSetTop;
		data['visible'] = this.visible;
		return data;
	}
}
