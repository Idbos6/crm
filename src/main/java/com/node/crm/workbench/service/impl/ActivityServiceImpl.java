package com.node.crm.workbench.service.impl;

import com.node.crm.settings.dao.UserDao;
import com.node.crm.settings.domain.User;
import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.dao.ActivityDao;
import com.node.crm.workbench.dao.ActivityRemarkDao;
import com.node.crm.workbench.domain.Activity;
import com.node.crm.workbench.domain.ActivityRemark;
import com.node.crm.workbench.service.ActivityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActivityServiceImpl implements ActivityService {

    // 引用类型自动注入:
    // @Autowired:
    //              @Autowired注解是按照类型（byType）装配依赖对象，默认情况下它要求依赖对象必须存在，如果允许null值，
    //              可以设置它的required属性为false。如果我们想使用按照名称（byName）来装配，可以结合@Qualifier注解一起使用。
    // @Resource:
    //              @Resource默认按照ByName自动注入，由J2EE提供，需要导入包javax.annotation.Resource。
    //              @Resource有两个重要的属性：name和type，而Spring将@Resource注解的name属性解析为bean的名字，而type属性则解析为bean的类型。
    //              所以，如果使用name属性，则使用byName的自动注入策略，而使用type属性时则使用byType自动注入策略。
    //              如果既不制定name也不制定type属性，这时将通过反射机制使用byName自动注入策略。
    @Resource
    private ActivityDao activityDao;

    @Resource
    private ActivityRemarkDao activityRemarkDao;

    @Resource
    private UserDao userDao;


    @Override
    public PaginationVO<Activity> pageList(Map<String, Object> map) {
        //取得total
        int total = activityDao.getTotalByCondition(map);

        //取得dataList
        List<Activity> dataList = activityDao.getActivityListByCondition(map);

        //创建一个vo对象，将total和dataList封装到vo中
        PaginationVO<Activity> vo = new PaginationVO<Activity>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        //将vo返回
        return vo;
    }

    @Override
    public Activity detail(String id) {

        Activity a = activityDao.detail(id);
        return a;

    }

    @Override
    public boolean save(Activity a) {

        boolean flag = true;
        int count = activityDao.save(a);

        if (count != 1) {

            flag = false;

        }

        return flag;
    }

    @Override
    public boolean delete(String[] ids) {

        boolean flag = true;

        //查询出需要删除的备注的数量
        int count1 = activityRemarkDao.getCountByAids(ids);

        //删除备注，返回受到影响的条数（实际删除的数量）
        int count2 = activityRemarkDao.deleteByAids(ids);

        if (count1 != count2) {

            flag = false;

        }

        //删除市场活动
        int count3 = activityDao.delete(ids);
        if (count3 != ids.length) {

            flag = false;

        }

        return flag;
    }

    @Override
    public boolean saveRemark(ActivityRemark ar) {

        boolean flag = true;

        int count = activityRemarkDao.saveRemark(ar);

        if (count != 1) {

            flag = false;

        }

        return flag;
    }

    @Override
    public List<ActivityRemark> getRemarkListByAid(String id) {

        List<ActivityRemark> list = activityRemarkDao.getRemarkListByAid(id);
        return list;

    }

    @Override
    public boolean deleteRemark(String id) {

        boolean flag = true;

        int count = activityRemarkDao.deleteById(id);

        if (count != 1) {

            flag = false;

        }

        return flag;

    }

    @Override
    public boolean updateRemark(ActivityRemark ar) {

        boolean flag = true;

        int count = activityRemarkDao.updateRemark(ar);

        if (count != 1) {

            flag = false;

        }

        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndActivity(String id) {

        //取uList
        List<User> uList = userDao.getUserList();

        //取a
        Activity a = activityDao.getById(id);

        //将uList和a打包到map中
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("uList", uList);
        map.put("a", a);

        //返回map就可以了
        return map;

    }

    @Override
    public boolean update(Activity a) {
        boolean flag = true;

        int count = activityDao.update(a);
        if (count != 1) {

            flag = false;

        }

        return flag;
    }
}
