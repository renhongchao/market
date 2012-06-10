package cn.com.carit.market.dao.permission;

import java.util.List;

import cn.com.carit.market.bean.BaseField;
import cn.com.carit.market.common.utils.DataGridModel;
import cn.com.carit.market.common.utils.JsonPage;

public interface BaseFieldDao {
	/**
	 * 增加
	 * @param field
	 * @return
	 */
	int add(BaseField field);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	int delete(int id);
	
	/**
	 * 更新
	 * @param field
	 * @return
	 */
	int update(BaseField field);
	
	/**
	 * 按Id查询
	 * @param id
	 * @return
	 */
	BaseField queryById(int id);
	
	/**
	 * 按字段名字查询
	 * @param filed
	 * @return
	 */
	List<BaseField> queryByField(String filed);
	
	/**
	 * 查询
	 * @return
	 */
	List<BaseField> query();
	
	/**
	 * 条件查询
	 * @param field
	 * @return
	 */
	List<BaseField> queryByExemple(BaseField field);
	
	/**
	 * 带分页的条件查询
	 * @param field
	 * @param dgm
	 * @return
	 */
	JsonPage<BaseField> queryByExemple(BaseField field, DataGridModel dgm);
	
	/**
	 * 检测字典名称是否存在
	 * @param field
	 * @return
	 */
	int checkField(String field);
	
	/**
	 * 按字段名返回limit条记录
	 * @param field
	 * @param limit
	 * @return
	 */
	List<BaseField> queryByField(String field, int limit);
}
