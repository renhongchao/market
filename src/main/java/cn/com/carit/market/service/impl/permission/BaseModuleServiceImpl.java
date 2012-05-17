package cn.com.carit.market.service.impl.permission;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.com.carit.market.bean.BaseModule;
import cn.com.carit.market.common.utils.DataGridModel;
import cn.com.carit.market.common.utils.JsonPage;
import cn.com.carit.market.dao.permission.BaseModuleDao;
import cn.com.carit.market.dao.permission.BaseRoleModuleDao;
import cn.com.carit.market.service.permission.BaseModuleService;
@Service
@Transactional(propagation=Propagation.SUPPORTS,readOnly=true)
public class BaseModuleServiceImpl implements BaseModuleService{
	
	@Resource
	private BaseModuleDao baseModuleDao;
	
	@Resource
	private BaseRoleModuleDao baseRoleModuleDao;
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false)
	public int saveOrUpdate(BaseModule baseModule) {
		if (baseModule==null) {
			throw new NullPointerException("baseModule object is null...");
		}
		if (baseModule.getId()==0) {
			return baseModuleDao.add(baseModule);
		}
		return baseModuleDao.update(baseModule);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false)
	public int delete(int id) {
		if (id<=1) {//顶级模块不能删除
			throw new IllegalArgumentException("id must bigger than 0...");
		}
		// 删除角色模块
		baseRoleModuleDao.deleteByModuleId(id);
		// 删除模块
		return baseModuleDao.delete(id);
	}

	@Override
	public BaseModule queryById(int id) {
		if (id<=0) {
			throw new IllegalArgumentException("id must bigger than 0...");
		}
		return baseModuleDao.queryById(id);
	}

	@Override
	public List<BaseModule> query() {
		return baseModuleDao.query();
	}

	@Override
	public List<BaseModule> queryByExemple(BaseModule baseModule) {
		if (baseModule==null) {
			throw new NullPointerException("must given an exemple...");
		}
		return baseModuleDao.queryByExemple(baseModule);
	}

	@Override
	public JsonPage queryByExemple(BaseModule baseModule, DataGridModel dgm) {
		if (baseModule==null) {
			throw new NullPointerException("must given an exemple...");
		}
		return baseModuleDao.queryByExemple(baseModule, dgm);
	}

	@Override
	public int getCount(BaseModule baseModule) {
		if (baseModule==null) {
			throw new NullPointerException("must given an exemple...");
		}
		return baseModuleDao.getCount(baseModule);
	}

	@Override
	public List<BaseModule> queryByUserId(int userId) {
		if (userId<=0) {
			throw new IllegalArgumentException("userId must bigger than 0...");
		}
		return baseModuleDao.queryByUserId(userId);
	}

	@Override
	public List<BaseModule> queryByRoleId(int roleId) {
		if (roleId<=0) {
			throw new IllegalArgumentException("roleId must bigger than 0...");
		}
		return baseModuleDao.queryByRoleId(roleId);
	}
	
	
}