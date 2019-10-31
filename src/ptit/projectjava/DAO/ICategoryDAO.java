package ptit.projectjava.DAO;

import java.util.List;

import ptit.projectjava.entity.Category;

public interface ICategoryDAO {
	public List<Category> getCategoryList();
	public Category getCategoryById(Integer id);
	public Category getCategorybyName(String name);
	public Category isCategoryNameExist(String name, Integer id);
	public void addCategory(Category category);
	public void updateCategory(Category category);
	public void deleteCategory(Integer Id);
	
}
