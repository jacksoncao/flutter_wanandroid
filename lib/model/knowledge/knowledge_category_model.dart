
//知识体系分类model，一级分类和二级分类都是这个model
class KnowledgeCategoryModel{

	List<KnowledgeCategoryModel> children; //包含的下一级分类数据集合
	int courseId;
	int id;  //查看该目录下的文章时会被用到
	String name; //知识分类名称
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;

	KnowledgeCategoryModel({this.children, this.courseId, this.id, this.name, this.order, this.parentChapterId, this.userControlSetTop, this.visible});

	KnowledgeCategoryModel.fromJson(Map<String, dynamic> json) {
		if (json['children'] != null) {
			children = new List<KnowledgeCategoryModel>();
			json['children'].forEach((v) { children.add(KnowledgeCategoryModel.fromJson(v)); });
		}
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
		if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
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
